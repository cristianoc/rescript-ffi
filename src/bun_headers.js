// Generated by ReScript, PLEASE EDIT WITH CARE


var HeadersInit = {};

var make = (()=> new Headers());

var makeWithInit = (init => new Headers(init));

var $$Headers = {
  make: make,
  makeWithInit: makeWithInit
};

var headers = make();

headers.append("Set-Cookie", "foo=bar");

var Test = {
  headers: headers
};

export {
  HeadersInit ,
  $$Headers ,
  Test ,
}
/* headers Not a pure module */
