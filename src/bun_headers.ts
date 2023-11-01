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
interface Headers {
    append(name: string, value: string): void;
    delete(name: string): void;
    get(name: string): string | null;
    has(name: string): boolean;
    set(name: string, value: string): void;
    entries(): IterableIterator<[string, string]>;
    keys(): IterableIterator<string>;
    values(): IterableIterator<string>;
    [Symbol.iterator](): IterableIterator<[string, string]>;
    forEach(
      callbackfn: (value: string, key: string, parent: Headers) => void,
      thisArg?: any,
    ): void;
  
    /**
     * Convert {@link Headers} to a plain JavaScript object.
     *
     * About 10x faster than `Object.fromEntries(headers.entries())`
     *
     * Called when you run `JSON.stringify(headers)`
     *
     * Does not preserve insertion order. Well-known header names are lowercased. Other header names are left as-is.
     */
    toJSON(): Record<string, string>;
  
    /**
     * Get the total number of headers
     */
    readonly count: number;
  
    /**
     * Get all headers matching the name
     *
     * Only supports `"Set-Cookie"`. All other headers are empty arrays.
     *
     * @param name - The header name to get
     *
     * @returns An array of header values
     *
     * @example
     * ```ts
     * const headers = new Headers();
     * headers.append("Set-Cookie", "foo=bar");
     * headers.append("Set-Cookie", "baz=qux");
     * headers.getAll("Set-Cookie"); // ["foo=bar", "baz=qux"]
     * ```
     */
    getAll(name: "set-cookie" | "Set-Cookie"): string[];
  }
  
  declare var Headers: {
    prototype: Headers;
    new (init?: HeadersInit): Headers;
  };
  