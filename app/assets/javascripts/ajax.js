$(()=>init());

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
  constructor(name, city){
    this.name = name
    this.city = city    
  }
}

Dealership.appendNewDealership = function(json){
  debugger
  const dealership = new Dealership(json);
}

Dealership.formSubmit = function(e){
  e.preventDefault();
  let $form = $(this);
  let action = $form.attr("action");
  let name = $("#dealership-name").val()
  let city = $("#dealership-city").val()
  debugger
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
    debugger
    resp=>resp.json()

  })
  .then(Dealership.appendNewDealership)
  .catch(displayIfAnyErrors)
}

Dealership.formSubmitListener = function(){
  $("form").on("submit", Dealership.formSubmit)
}

renderNewDealershipModal = function(){
  let newDealershipHTML = $("#new-dealership-modal").html()
  $("main")[0].innerHTML += newDealershipHTML
  Dealership.formSubmitListener();
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
