// ----------------------------------------------------------

// https://es6console.com/jj9heuzv/
function setup() {
  // Write your code here.
  const elements = document.getElementsByTagName("span");
  Array.prototype.forEach.call(elements, function(element) {
    element.addEventListener("click", function(){
      
      element.classList.add('active');

      let previous = element.previousElementSibling;
      while(previous != null){
        previous.classList.add('active');
        previous = previous.previousElementSibling;
      }

      let next = element.nextElementSibling;
      while(next != null){
        next.classList.remove('active');
        next = next.nextElementSibling; 
      }

    });
  });
}

// Example case. 
document.body.innerHTML = `
<div>
  <span></span>
  <span></span>
  <span></span>
  <span></span>
  <span></span>
  <span></span>
</div>`;

setup();

document.getElementsByTagName("span")[2].click();
console.log(document.body.innerHTML);