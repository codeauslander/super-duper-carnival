function appendChildren(decorateDivFunction) {
  var allDivs = document.getElementsByTagName("div");
  var length =  allDivs.length;
  for (var i = 0; i < length; i++) {
    var newDiv = document.createElement("div");
    decorateDivFunction(newDiv);
    allDivs[i].appendChild(newDiv);
  }
}

// Example case. 
document.body.innerHTML = `
<div id="a">
  <div id="b">
  </div>
</div>`;

//appendChildren(function(div) {});
console.log(document.body.innerHTML);

// var x = document.getElementById("myLI").parentElement.remove();
// ----------------------------------------------------------

function formatDate(userDate) {
  // format from M/D/YYYY to YYYYMMDD
  const date = userDate.split('/');
  let month = date[0];
  let day = date[1];
  let year = date[2];
  if (month.length === 1){
    month = '0'+month
  }
  if (day.length === 1){
    day = '0'+day
  }
   
  return `${year}${month}${day}`
}

console.log(formatDate("12/31/2014"));

// ----------------------------------------------------------

function setup() {
  // Write your code here.
  const elements = document.getElementsByClassName("remove");
  Array.prototype.forEach.call(elements, function(element) {
    element.addEventListener("click", function(){
      element.parentElement.remove();
    });
  });
}

// Example case. 
document.body.innerHTML = `
<div class="image">
  <img src="https://goo.gl/kjzfbE" alt="First">
  <button class="remove">X</button>
</div>
<div class="image">
  <img src="https://goo.gl/d2JncW" alt="Second">
  <button class="remove">X</button>
</div>`;

setup();

document.getElementsByClassName("remove")[0].click();
console.log(document.body.innerHTML);




