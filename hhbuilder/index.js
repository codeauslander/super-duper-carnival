console.log('now');
var elements = {
  form: document.querySelector('.builder form'),
  addButton: document.querySelector('.builder form .add'),
  ageInput: document.querySelector('.builder form input[name="age"]'),
};

var state = {
  age: {value:'',error:''},
}


elements.addButton.addEventListener('click', function (event) {
  event.preventDefault();
  var age = parseFloat(elements.ageInput.value);
  if (isNaN(age) || age <= 0){

    var ageError = document.createElement('span');
    elements.ageInput.parentNode.appendChild(ageError);

    state.age.error = 'Please enter a number higher than 0';
    ageError.innerHTML = state.age.error ;

  } else {
    state.age.error = '';
    state.age.value = age;
  }

  return false;
}, false);
