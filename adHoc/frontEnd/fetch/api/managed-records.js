import fetch from "../util/fetch-fill";
import URI from "urijs";

window.path = "http://localhost:3000/records";

function isPrimary(argument) {
  return (argument === 'red' || argument === 'blue' || argument === 'yellow');
}

function getResults(section,uriQuery, results,index) {
  if (index >= section.length) {
    return results;
  }
  if (results === null) {
    results = {'ids': [], 'open': [], 'closedPrimaryCount': 0, 'previousPage': null, 'nextPage': 2};
    if (uriQuery.offset !== 0) {
      results.previousPage = uriQuery.offset;
      results.nextPage = uriQuery.offset + 2;
    }
  }
  var object = section[index];
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
  return getResults(section,uriQuery,results,index + 1);
}

function getSection(startIndex, end, amount, section = [], list) {
  console.log(section.length);
  if (section.length === 10 && section != undefined) {
    console.log(section);
    return section;
  }
  section.push(list[startIndex]);
  return getSection(startIndex + 1, end,amount, section, list);
}

function getData(uri, uriQuery, offset, end, start, amount) {

  uriQuery.limit = end;
  uri.setSearch(uriQuery);

  // `return  fetch(uri).then(function (response) {
    //   return response.json();
    // }).catch(function(error) {
    //   console.log(error,'error');
    // });`
  
  return  fetch(uri).then(function (response) {
    return response.json();
  }).then(function (data) {
    console.log('data', data[0]);
    return getSection(start, end, amount, [], data);
  }).then(function (section) {
    console.log('section', section);
    return getResults(section, uriQuery, null, 0);
  }).catch(function(error) {
    console.log(error,'error');
  });

}

function retrieve(options) {
  console.log(options,options);
  var uri = new URI(window.path); 
  var uriQuery = {'limit': 10, 'offset': 0, 'color[]': ["red", "brown", "blue", "yellow", "green"]};
  if (options !== undefined) {
    uriQuery.limit = options.limit === undefined ? uriQuery.limit : options.limit;
    uriQuery.offset = options.page === undefined ? uriQuery.offset : (options.page - 1);
    uriQuery['color[]'] = options.colors === undefined ? uriQuery['color[]'] : options.colors;
  }
  
  uri.setSearch(uriQuery);

  console.log('uriQuery',uriQuery);

  var amount = uriQuery.limit;
  var end = amount * (uriQuery.offset + 1);
  var start = end - amount;
  if (uriQuery.offset != 0) {
    start = start - (uriQuery.offset);
  }


  return getData(uri, uriQuery, uriQuery.offset, end, start, amount);

}
export default retrieve;
