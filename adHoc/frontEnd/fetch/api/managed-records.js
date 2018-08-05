import fetch from "../util/fetch-fill";
import URI from "urijs";

// /records endpoint
window.path = "http://localhost:3000/records";

// Your retrieve function plus any additional functions go here ...

function retrieve(options) {
  console.log('options',options);
  var uri = new URI(window.path); 
  if (options !== undefined) {
    uri.setSearch({limit: 10});
    if (options.page === undefined || options.page === 1) {
      uri.setSearch({offset: 0});
    } else {
      uri.setSearch({offset: (options.page - 1) * 10});
    }
    if (options.colors !== undefined) {
      uri.setSearch({'color[]': options.colors});
    }
  }
  // here start the request using fetch fetch(path).then.....
  return fetch(uri)
  .then(function (response) {
    return response.json();
  })
  .then(function (data) {
    console.log(data);
    var results = {};
    switch (options.page) {
      case undefined:
          results.previousPage = null;
          break;
      case 1:
          results.previousPage = null;
          break;
      default:
          results.previousPage = (options.page - 1);
    }
    
    results.nexPage = null;
    results.ids = [];
    results.open = [];
    results.closedPrimaryCount = 0;

    data.forEach(function(object) {
      results.ids.push(object.id)
      if (object.disposition === 'open') {
          results.open.push({
              id: object.id,
              color: object.color,
              disposition: object.disposition,
              isPrimary: (object.color === 'red' || object.color === 'blue' || object.color === 'yellow'
                  ? true
                  : false)
          });
      } else if (object.disposition === 'closed') {
          results.closedPrimaryCount++;  
      }
    });

    if (options.page === 1 && options.colors === undefined) {
      results.nextPage = 2;
    } else if (results.ids.length <= 10 || options.page > 2) {
        results.nextPage = null;
    } else if (options.page === undefined) {
        results.nextPage = 2;
    } else {
        results.nextPage = (options.page + 1);
    } 
    console.log(results);
    return results;
  })
  .catch(function(error) {
    console.log(error,'error');
  });
}

export default retrieve;
