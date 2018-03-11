$(function(){
  init()});

function init(){
  attachListeners()
  handlebarsDebugger()  
}

let attachListeners = function(){
  //Attach click event to display all dealerships
  viewAllDealershipsListener();
  viewVehicle();
  displayCommandCenter();
  menuComandCenter();
};

// Create Dealership class
class Dealership{
  constructor(attributes){    
    this.name = attributes.name
    this.city = attributes.city    
    this.vehicles = attributes.vehicles
  }
  renderNewDealershipDiv(){
    return Dealership.template(this)
  }
  handleValidations(errors){
    this.styleErrors(errors)
  }
  styleErrors(errors){
    var errmsg = `<ul class="validations">`
    for(let err in errors){
    $(`#dealership-${err}`).css({'border-color': 'red'})
    }    
    (function(){
      for(let err in errors){
        errmsg += `<li id=${err}>${errors[err]}</li>`
      }
      errmsg += `</ul>`
    })();
    this.prependErrors(errmsg)    
  }
  prependErrors(errmsg){
    $(".modal-body").prepend(errmsg)
  }
}

Dealership.appendNewDealership = function(json){
  if(!json.hasOwnProperty("vehicles") && !json.hasOwnProperty("id")){
    let dealershipError = new Dealership(json)
    dealershipError.handleValidations(json)
  }else{    
  const dealership = new Dealership(json);
  const dealershipDiv = dealership.renderNewDealershipDiv()
  $(".js-dealership-list").append(dealershipDiv)
  $('#new-dealership').modal('toggle');
  }
}

Dealership.error = function(error){
  console.log("The request did not succeed", error)
}

Dealership.formSubmit = function(e){
  e.preventDefault()
  let $form = $(this);
  let action = $form.attr("action");
  let params = $form.serialize();
  $.ajax({
    url: action,
    data: params,
    dataType: 'json',
    method: 'POST'
  })
  .success(Dealership.appendNewDealership)
  .error(Dealership.error)
}


/* This would return params where the name and city values were duplicated. 
Dealership.formSubmit = function(e){
  e.preventDefault();
  let $form = $(this);
  let action = $form.attr("action");
  let name = $("#dealership-name").val()
  let city = $("#dealership-city").val()
  fetch(action, {
    body: JSON.stringify({name: name, city: city}),
    credentials: 'same-origin',
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content'),
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    method: "POST"
  })
  .then(handleErrors)
  .then(function(e){
    resp=>resp.json()
  })
  .then(Dealership.appendNewDealership)
  .catch(displayIfAnyErrors)
}
*/

Dealership.resetForm = function(e){
  $ulForm = $(".validations");
  if($("#name").length > 0){
    $("#dealership-name").css({'border-color': '#ced4da'})
  }if($("#city").length > 0){
    $("#dealership-city").css({'border-color': '#ced4da'})
  }if($ulForm.length > 0){
    $ulForm.remove();
  }
  Dealership.hideErrorIcons(e);
  Dealership.checkInputs();
}

Dealership.hideErrorIcons = function(e){
  if(!$("#dealership-name").val().length >= 1){
    $("#js-error-name").hide() 
  }
  if(!$("#dealership-city").val().length >= 1){
    $("#js-error-city").hide();
  }  
}

Dealership.checkInputs = function(){
  $("#dealership-name, #dealership-city").on("keyup", function(e){
    e.preventDefault();
    let params = {};
    if(e.currentTarget.id === "dealership-name"){
      let name = $("#dealership-name").val();
      params.name = name;
    }else{
      let city = $("#dealership-city").val();
      params.city = city;
    }
    $.ajax({
      url: '/dealership_validation',
      type: 'GET',
      dataType: 'json',
      data: params
    })
    .success(function(json){
      Dealership.showIcons(json)
    })
    .error(function(error){
    })
  })
}

Dealership.cityValid = function(json){
  return (json.city === true) || ($("#dealership-city").val().length === 0) ? true :false  
}

Dealership.handleCityErrorIcon = function(json){
  if(Dealership.cityValid(json)){
    //hide icon
    Dealership.notifyUserCitySuccess(json)
  }else{
    //show icon
    Dealership.notifyUserCityFailure(json)
  }
}

Dealership.notifyUserCityFailure = function(json){
  let errorCity = $("#js-error-city")
  if(errorCity.hasClass("checkspan")){
    $(errorCity).removeClass("fa fa-check-circle checkspan").addClass("fa fa-exclamation-circle errspan")
    $(errorCity).show();
  }else{
    $(errorCity).show();
  }
}

Dealership.notifyUserNameFailure = function(json){
  let errorName = $("#js-error-name")
  if(errorName.hasClass("checkspan")){
    $(errorName).removeClass("fa fa-check-circle checkspan").addClass("fa fa-exclamation-circle errspan");
    $(errorName).show();
  }else{
    $(errorName).show();
  }
}

Dealership.notifyUserNameSuccess = function(json){
  let nameSuccess = $("#js-error-name");
  if($("#dealership-name").val().length !==0){
    $(nameSuccess).removeClass("fa fa-exclamation-circle errspan").addClass("fa fa-check-circle checkspan")
    $(nameSuccess).show();
  }else{
    $(nameSuccess).hide()
  }
}

Dealership.notifyUserCitySuccess = function(json){
  let citySuccess = $("#js-error-city");
  if($("#dealership-city").val().length !==0){
    $(citySuccess).removeClass("fa fa-exclamation-circle errspan").addClass("fa fa-check-circle checkspan")
    $(citySuccess).show();
  }else{
    $(citySuccess).hide()
  }
}

Dealership.nameValid = function(json){
  if((json.name === true && json.uniquness === true) || ($("#dealership-name").val().length === 0)){
      return true
  }else{
    return false
  }
}

Dealership.handleNameErrorIcon = function(json){
  if(Dealership.nameValid(json)){
    //hide icon
    Dealership.notifyUserNameSuccess(json)
  }else{
    //show icon
    Dealership.notifyUserNameFailure(json)
  }
}

Dealership.showIcons = function(json){
  if("name" in json){
    Dealership.handleNameErrorIcon(json)
  }else{
    Dealership.handleCityErrorIcon(json)
  }
}


Dealership.formSubmitListener = function(){
  $("form").on("submit", Dealership.resetForm)
            .on('submit', Dealership.formSubmit)
}

renderNewDealershipModal = function(){
  Dealership.templateSource = $("#dealership-div-template").html();
  Dealership.template = Handlebars.compile(Dealership.templateSource);
  let newDealershipHTML = $("#new-dealership-modal").html()
  $("main")[0].innerHTML += newDealershipHTML
  Dealership.formSubmitListener();
  Dealership.resetForm();
}

const path = (obj) => $(obj).attr("href")

// Display Command Center
function menuComandCenter(){$(document).on("click", "#js-nav-cc", getCommandCenter)}

function displayCommandCenter(){$(document).on("click", "#js-command-center", getCommandCenter)}

function getCommandCenter(e){
  e.preventDefault()
  fetch(path(this),{
    credentials: 'same-origin',
    headers: {
      'Accept': 'application/json'
    }
  })
  .then(handleErrors)
  .then(resp=>resp.json())
  .then(renderCommandCenter)
  .catch(displayIfAnyErrors)
}

let renderCommandCenter = function(json){
  let commandCenterTemplateHTML = $("#command-center-template").html()
  let compiledTemplate = Handlebars.compile(commandCenterTemplateHTML)
  let readyHTML = compiledTemplate(json)
  $("main")[0].innerHTML = readyHTML;
}

// View vehicle fetch

function viewVehicle(){$(document).on("click", "#js-view-vehicle", getVehicle)};

function getVehicle(e){
  e.preventDefault()
  fetch(path(this),{
    credentials: 'same-origin',
    headers: {
      'Accept': 'application/json'
    }
  })
  .then(handleErrors)
  .then(resp=>resp.json())
  .then(renderVehicle)
  .catch(displayIfAnyErrors)
}

let renderVehicle = function(json){
  let vehicleTemplateHTML = $("#vehicle-template").html();
  let compiledTemplate = Handlebars.compile(vehicleTemplateHTML)
  let readyHTML = compiledTemplate(json)
  $("main")[0].innerHTML  = readyHTML;
}

// View All Dealership fetch

function viewAllDealershipsListener(){$(document).on("click", "#js-all-dealerships", getAllDealerships)};

function getAllDealerships(e){
  e.preventDefault()
  //let path = $(this).attr("href");
  fetch(path(this), {
    credentials: 'same-origin',
    headers: {
      'Accept': 'application/json'
    }
  })
  .then(handleErrors)
  .then(resp=>resp.json())
  .then(renderAllDealerships)
  .catch(displayIfAnyErrors)
}

let renderAllDealerships = function(json){
  registerHandlebarPartial();
  let dealershipTemplateHTML = $("#dealerships-template").html();
  let compiledTemplate = Handlebars.compile(dealershipTemplateHTML);
  let readyHTML = compiledTemplate(json);
  $("main")[0].innerHTML = readyHTML;  
}

function registerHandlebarPartial(){
  Handlebars.registerPartial("dealershipPartial", $("#dealership-template").html())
}

$(function(){
  Handlebars.registerHelper("vehicleStatus", function(){
    return this.dealership_vehicle.is_lot_ready === true ? "Lot ready" : "In repair"
  })
})

// Used for debugging Handlebars, drop {{debug}} in the code to see what values handlebars is working with
function handlebarsDebugger(){
  Handlebars.registerHelper("debug", function(optionalValue) {
  console.log("Current Context");
  console.log("====================");
  console.log(this);
     
  if (optionalValue) {
    console.log("Value");
    console.log("====================");
    console.log(optionalValue);
    }
  });
}

let displayIfAnyErrors = (error) => console.error('Error:', error)

let handleErrors = function(res){
  if (res.ok){
    return res
  }
  throw Error(res.statusText);
}
