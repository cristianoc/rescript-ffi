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

  @new external make: unit => t = "Headers"
  @new external makeWithInit: HeadersInit.t => t = "Headers"

  @send external append: (t, string, string) => unit = "append"
  @send external delete: (t, string) => unit = "delete"
  @return(nullable) @send external get: (t, string) => option<string> = "get"
  @send external has: (t, string) => bool = "has"
  @send external set: (t, string, string) => unit = "set"
  @send external entries: t => Iterator.t<(string, string)> = "entries"
  @send external keys: t => Iterator.t<string> = "keys"
  @send external values: t => Iterator.t<string> = "values"
  @send external forEach: (t, (string, string, t) => unit) => unit = "forEach"

  /**
   * Convert {@link Headers} to a plain JavaScript object.
   *
   * About 10x faster than `Object.fromEntries(headers.entries())`
   *
   * Called when you run `JSON.stringify(headers)`
   *
   * Does not preserve insertion order. Well-known header names are lowercased. Other header names are left as-is.
   */
  @send
  external toJSON: t => Dict.t<string> = "toJSON"

  /**
   * Get the total number of headers
   */
  @get
  external count: t => int = "count"

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