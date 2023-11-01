module HeadersInit = {
  @unboxed type t = FromArray(array<(string, string)>) | FromDict(Js.Dict.t<string>)
}

/**
 * This Fetch API interface allows you to perform various actions on HTTP
 * request and response headers. These actions include retrieving, setting,
 * adding to, and removing. A Headers object has an associated header list,
 * which is initially empty and consists of zero or more name and value
 * pairs.
 *
 * You can add to this using methods like append()
 *
 * In all methods of this interface, header names are matched by
 * case-insensitive byte sequence.
 */
module Headers = {
  type t

  let make : unit => t = %ffi(`()=> new Headers()`)
  let makeWithInit: HeadersInit.t => t = %ffi(`init => new Headers(init)`)

  let append: (t, string, string) => unit = %ffi(`(headers, name, value) => headers.append(name, value)`)
  let delete: (t, string) => unit = %ffi(`(headers, name) => headers.delete(name)`)

  let get: (t, string) => option<string> = %ffi(`(headers, name) => headers.get(name) ?? undefined`)
  let has: (t, string) => bool = %ffi(`(headers, name) => headers.has(name)`)
  let set: (t, string, string) => unit = %ffi(`(headers, name, value) => headers.set(name, value)`)
  let entries: t => Iterator.t<(string, string)> = %ffi(`headers => headers.entries()`)
  let keys: t => Iterator.t<string> = %ffi(`headers => headers.keys()`)
  let values: t => Iterator.t<string> = %ffi(`headers => headers.values()`)
  let forEach: (t, (string, string, t) => unit) => unit = %ffi(`(headers, callback) => headers.forEach(callback)`)

  /**
   * Convert {@link Headers} to a plain JavaScript object.
   *
   * About 10x faster than `Object.fromEntries(headers.entries())`
   *
   * Called when you run `JSON.stringify(headers)`
   *
   * Does not preserve insertion order. Well-known header names are lowercased. Other header names are left as-is.
   */
  let toJSON: t => Dict.t<string> = %ffi(`headers => headers.toJSON()`)

  /**
   * Get the total number of headers
   */
  let count: t => int = %ffi(`headers => headers.count`)
 
  /**
   * Get all headers matching "Set-Cookie"
   *
   * Only supports `"Set-Cookie"`. All other headers are empty arrays.
   *
   * @returns An array of header values
   *
   * @example
   * ```rescript
   * let headers = Headers.make()
   * headers->Headers.append("Set-Cookie", "foo=bar")
   * headers->Headers.append("Set-Cookie", "baz=qux")
   * let cookies = headers->Headers.getAllCookies // ["foo=bar", "baz=qux"]
   * ```
   */
  @send
  external getAllCookies: (t, @as("Set-Cookie") _) => array<string> = "getAll"
}

module Test = {
  let headers = Headers.make()
  headers->Headers.append("Set-Cookie", "foo=bar")
  let cookie = headers->Headers.get("Set-Cookie")
}
