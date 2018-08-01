import fetch from "../util/fetch-fill";
import URI from "urijs";

// /records endpoint
window.path = "http://localhost:3000/records";

// Your retrieve function plus any additional functions go here ...

function retrieve(options) {
  var uri = new URI(window.path); 
  if (options !== undefined) {
    uri.setSearch({limit: 10});
    switch (options.page) {
      case undefined:
          uri.setSearch({offset: 0});
          break;
      case 1:
          uri.setSearch({offset: 0});
          break;
      case 2:
          uri.setSearch({offset: 10});
          break;
      case 3:
          uri.setSearch({offset: 20});
          break;
    }
    if (options.colors !== undefined) {
      uri.setSearch({'color[]': options.colors});
    }
  }
  // here start the request using fetch fetch(path).then.....
}

export default retrieve;
