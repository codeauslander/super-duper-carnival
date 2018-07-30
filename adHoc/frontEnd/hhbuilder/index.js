var elements = {
  form: document.querySelector('.builder form'),
  addButton: document.querySelector('.builder form .add'),
  ageInput: document.querySelector('.builder form input[name="age"]'),
  relSelect: document.querySelector('.builder form select[name="rel"]'),
  smokerCheckbox: document.querySelector('.builder form input[name="smoker"]'),
  householdOrderList: document.querySelector('.household'),
  submitButton: document.querySelector('.builder form button[type="submit"]'),
  notificationSpans: document.getElementsByClassName('notification'),
  debug: document.querySelector('.debug'),
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
  notification.setAttribute('class','notification');
  var parentNotification = elementInput.parentNode;
  if (parentNotification.getElementsByClassName('notification').length === 0) {
    parentNotification.appendChild(notification);
    notification.innerHTML = message;
  }
  
}

function addRemoveButton(element) {
  var button = document.createElement('input');
  button.setAttribute('type', 'button');
  button.setAttribute('value', 'remove');

  button.addEventListener('click',function(){
    delete state.householdList[element.id];
    // renderList(elements.householdOrderList,state.householdList);
    element.parentNode.removeChild(element);
  });

  element.appendChild(button);
}

function addHousehold(id,age,rel,smoker) {
  var household = {id: id, age: age, rel: rel, smoker: smoker};
  state.householdList.push(household);

  var householdLi = document.createElement('li');
  householdLi.setAttribute('id',id);
  householdLi.innerHTML = `id: ${id}, age: ${age}, relationship: ${rel}, smoker: ${smoker}`;
  elements.householdOrderList.appendChild(householdLi);

  addRemoveButton(householdLi);

  cleanInputs();
}

function cleanInputs() {
  cleanNotifications();
  elements.ageInput.value = state.age.value = '';
  elements.relSelect.value = state.rel.value= '';
  elements.smokerCheckbox.checked = state.smoker.value = false;
}

function cleanNotifications() {
  if (elements.notificationSpans.length) {
    [].forEach.call(elements.notificationSpans,function(notificationSpan){
      notificationSpan.parentNode.removeChild(notificationSpan);
    });
  }
}

function successPost(listJson,button,message) {
  elements.debug.style = "display:block";
  elements.debug.innerHTML = listJson,message;
  displayNotification(button,message);
}

elements.addButton.addEventListener('click', function (event) {
  event.preventDefault();
  cleanNotifications();

  var age = parseFloat(elements.ageInput.value);
  if (isNaN(age) || age <= 0){
    state.age.error = 'Please enter a number higher than 0';
    displayNotification(elements.ageInput,state.age.error);

  } else {
    state.age.error = '';
    state.age.value = age;
  }

  var rel = elements.relSelect.value;

  if (rel === '') {
    state.rel.error = 'Please select a relationship';
    displayNotification(elements.relSelect,state.rel.error);
  } else {
    state.rel.error = '';
    state.rel.value = rel;
  }

  state.smoker.value = elements.smokerCheckbox.checked;

  if (state.age.error === '' 
      && state.rel.error === '' 
      && state.smoker.error === '') {

    addHousehold( 
      state.lastHousehold, 
      state.age.value, 
      state.rel.value, 
      state.smoker.value
    );
    state.lastHousehold = state.lastHousehold + 1;

  }

  return false;
}, false)

elements.submitButton.addEventListener('click', function(event) {
  event.preventDefault();
  cleanNotifications();
  cleanInputs();
  var householdJSON = JSON.stringify(state.householdList, null, 2);

  var url = 'http://example.com/household.json';
  fetch(url,{
    method: 'POST',
    body: householdJSON,
  }).then(function(response) {
    return response.json();
  }).then(function(data) {
    successPost(householdJSON, elements.submitButton, 'Household list saved');
  }).catch(function(error){
    console.log('the url is fake');
  });

  successPost(householdJSON, elements.submitButton, 'Household list saved');
});

