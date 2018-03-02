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
  .catch(error => console.error('Error:', error))
}

let renderCommandCenter = function(json){
  let commandCenterTemplateHTML = $("#command-center-template").html()
  let compiledTemplate = Handlebars.compile(commandCenterTemplateHTML)
  let readyHTML = compiledTemplate(json)
  $("main")[0].innerHTML = readyHTML;
}


// Create Dealership class

class Dealership{
  constructor(name, city){
    this.name = name
    this.city = city
  }
  templateSource(){
    return $("#btn-test").html();
  } 
}

function createDealership(){
  let name = $("#")
  const dealership = new Dealership()
}



Dealership.prototype.renderNewForm = (dealership) => console.log("test")



function createDealership(){$(document).on("click", "#btn-test", createDealershipObj)}

function createDealershipObj(e){
  e.preventDefault()
  fetch("/dealerships/new", {
    credentials: 'same-origin',
    headers: {
      'Accept': 'application/json'
    }
  })
  .then(handleErrors)
  .then(resp=>resp.json())
  .then(renderNewDealershipForm)
  .catch(error => console.error('Error:', error))
}

let renderNewDealershipForm = function(json){
  let newDealershipHTML = $("#test-template").html()
  let compiledTemplate = Handlebars.compile(newDealershipHTML)
  let readyHTML = compiledTemplate(json)
  $(".modal-body")[0].innerHTML = readyHTML
}

const path = (obj) => $(obj).attr("href")

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
  .catch(error => console.error('Error:', error))
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
  let path = $(this).attr("href");
  fetch(path, {
    credentials: 'same-origin',
    headers: {
      'Accept': 'application/json'
    }
  })
  .then(handleErrors)
  .then(resp=>resp.json())
  .then(renderAllDealerships)
  .catch(function(){
    if(error.message === "The partial dealershipPartial could not be found")
    {
      regiesterHandlebarPartial();
    }else{
      console.error('Error:', error);
    }
  })
}

let renderAllDealerships = function(json){
  let dealershipTemplateHTML = $("#dealerships-template").html();
  let compiledTemplate = Handlebars.compile(dealershipTemplateHTML);
  let readyHTML = compiledTemplate(json);
  $("main")[0].innerHTML = readyHTML;  
}

$(function regiesterHandlebarPartial(){
  let registerPartialWindow = $(".application.home")
  if (registerPartialWindow.length > 0){
    registerPartialWindow.ready(function(){
      Handlebars.registerPartial("dealershipPartial", $("#dealership-template").html())
    })    
  }
})

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

let handleErrors = function(res){
  if (res.ok){
    return res
  }
  throw Error(res.statusText);
}



