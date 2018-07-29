var elements = {
  form: document.querySelector('.builder form'),
  addButton: document.querySelector('.builder form .add'),
  ageInput: document.querySelector('.builder form input[name="age"]'),
  relSelect: document.querySelector('.builder form select[name="rel"]'),
  smokerCheckbox: document.querySelector('.builder form input[name="smoker"]'),
};

var state = {
  age: { value: '', error: '' },
  rel: { value: '', error: '' },
  smoker: { value: false, error: '' },
  householdList: [],
  lastHousehold: 0,
};




function displayNotification(elementInput,message) {
  var notification = document.createElement('span');
  elementInput.parentNode.appendChild(notification);
  notification.innerHTML = message;
}

function addHousehold(id,age,rel,smoker) {
  var household = {id: id, age: age, rel: rel, smoker: smoker};
  state.householdList.push(household);
}

elements.addButton.addEventListener('click', function (event) {
  event.preventDefault();

  var age = parseFloat(elements.ageInput.value);
  if (isNaN(age) || age <= 0){
    state.age.error = 'Please enter a number higher than 0';
    displayNotification(elements.ageInput,state.age.error);

  } else {
    state.age.error = '';
    state.age.value = age;
  }

  var rel = elements.relSelect;
  rel = rel.options[rel.selectedIndex].value;
  if (rel === '') {
    state.rel.error = 'Please select a relationship';
    displayNotification(elements.relSelect,state.rel.error);
  } else {
    state.rel.error = '';
    state.rel.value = rel;
  }

  state.smoker.value = elements.smokerCheckbox.checked;

  if (state.age.error === '' && state.rel.error === '' && state.smoker.error === '') {
    addHousehold(state.lastHousehold, state.age.value, state.rel.value, state.smoker.value);
    state.lastHousehold = state.lastHousehold + 1;
  }


  return false;
}, false);
