import fetch from "../util/fetch-fill";
import URI from "urijs";

window.path = "http://localhost:3000/records";

function isPrimary(argument) {
  return (argument === 'red' || argument === 'blue' || argument === 'yellow');
}

function unexpectedQuery(colors = [], checkColors = [], results = null, uriQuery = null) {
  if (results !== null) {
    if (results.previousPage === null && results.nextPage === null) {
      results.ids = [];
      results.open = [];
      results.closedPrimaryCount = 0;
      return results;
    } else if (results.previousPage === 50 ) {
      results.nextPage = null;
      results.ids = [];
      results.open = [];
      results.closedPrimaryCount = 0;
      return results;
    }
  } 
  if (colors !== []) {
    var badColors = colors.some(function(color){
      return checkColors.indexOf(color.toLowerCase()) < 0;
    });
    
    if (badColors) {
      console.log('bad colors',badColors);
      results =  {'ids': [], 'open': [], 'closedPrimaryCount': 0, 'previousPage': null, 'nextPage': null};
      results.previousPage = null ;
      results.nextPage = null;
      results.ids = [];
      results.open = [];
      results.closedPrimaryCount = 0;
      console.log('auxResults',results);
      return results;
    }
  }
  return false;
}

function getResults(section,uriQuery, results,index, check) {
  if (check) {
    return check;
  }
  if (index >= section.length) {
    return results;
  }
  if (results === null) {
    results = {'ids': [], 'open': [], 'closedPrimaryCount': 0, 'previousPage': null, 'nextPage': 2};
    if (uriQuery.offset !== 0) {
      results.previousPage =  uriQuery.offset + 1% section.length === 0 ? null : uriQuery.offset;
      results.nextPage = (uriQuery.offset + 1) % section.length === 0 ? null : uriQuery.offset + 2;
      check = unexpectedQuery([],[],results, uriQuery);
     
      if (check) { 
         console.log('check data',check);
        return check;
      }
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
  if (section.length === 10 && section != undefined) {
    return section;
  }
  section.push(list[startIndex]);
  return getSection(startIndex + 1, end,amount, section, list);
}

function getData(uri, uriQuery, offset, end, start, amount, check) {

  uriQuery.limit = end;
  uri.setSearch(uriQuery);
  
  return  fetch(uri).then(function (response) {
    return response.json();
  }).then(function (data) {
    return getSection(start, end, amount, [], data);
  }).then(function (section) {
    return getResults(section, uriQuery, null, 0, check);
  }).catch(function(error) {
    console.log(error,'error');
  });
}



function retrieve(options) {
  var uri = new URI(window.path); 
  var colors = ["red", "brown", "blue", "yellow", "green"];
  var uriQuery = {'limit': 10, 'offset': 0, 'color[]': colors};
  if (options !== undefined) {
    uriQuery.limit = options.limit === undefined ? uriQuery.limit : options.limit;
    uriQuery.offset = options.page === undefined ? uriQuery.offset : (options.page - 1);
    uriQuery['color[]'] = options.colors === undefined ? uriQuery['color[]'] : options.colors;
  }
  
  uri.setSearch(uriQuery);

  var amount = uriQuery.limit;
  var end = amount * (uriQuery.offset + 1);
  var start = end - amount;
  if (uriQuery.offset != 0) {
    start = start - (uriQuery.offset);
  }

  var check = unexpectedQuery(uriQuery['color[]'], colors, null);
  return getData(uri, uriQuery, uriQuery.offset, end, start, amount,check);

}
export default retrieve;
