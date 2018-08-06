import fetch from "../util/fetch-fill";
import URI from "urijs";

window.path = "http://localhost:3000/records";

function isPrimary(argument) {
  return (argument === 'red' || argument === 'blue' || argument === 'yellow');
}

// function getSliceData(uri) {
//   return fetch(uri)
//   .then(function (response) {
//     return response.json();
//   })
//   .then(function (allData) {
//     function deleteData(allData) {
//       if (allData.length > 10 ) {
//       allData.shift();
//       return deleteData(allData);
//     }
//     return allData;
//     }
//   });
// }

function retrieve(options) {
  console.log(options,options);
  var uri = new URI(window.path); 
  var uriQuery = {'limit': 10, 'offset': 0, 'color[]': ["red", "brown", "blue", "yellow", "green"]};
  if (options !== undefined) {
    uriQuery.limit = options.limit === undefined ? uriQuery.limit : options.limit;
    uriQuery.offset = options.page === undefined ? uriQuery.offset : (options.page - 1);
    uriQuery['color[]'] = options.colors === undefined ? uriQuery['color[]'] : options.colors;
  }
  uriQuery.limit = ( uriQuery.limit * (uriQuery.offset + 1) );
  uri.setSearch(uriQuery);
  console.log('uri',uriQuery)
  return fetch(uri)
  .then(function (response) {
    return response.json();
  })
  .then(function (allData) {
    // function deleteData(allData) {
    //   if (allData.length > 10 ) {
    //     return deleteData(allData.shift());
    //   }
    //   return allData;
    // }
    return allData;
  })
  // getSliceData(uri)
  .then(function (data) {
    var results = {'ids': [], 'open': [], 'closedPrimaryCount': 0, 'previousPage': null, 'nextPage': 2};
    if (uriQuery.offset !== 0) {
      results.previousPage = (uriQuery.offset - 1);
      results.nextPage = uriQuery.offset + 1;
    }
    data.forEach(function(object) {
        results.ids.push(object.id);
        if (object.disposition === 'open') {
            results.open.push({
                id: object.id,
                color: object.color,
                disposition: object.disposition,
                isPrimary: isPrimary(object.color),
            });
        } else if (object.disposition === 'closed' && isPrimary(object.color)) {
            results.closedPrimaryCount = results.closedPrimaryCount + 1;  
        }
    });
    return results;
  })
  .catch(function(error) {
    console.log(error,'error');
  });
}
export default retrieve;
