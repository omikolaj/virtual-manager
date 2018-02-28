$(()=>init());

function init(){
  attachListeners()
  handlebarsDebugger()
}

let attachListeners = function(){
  //Attach click event to display all dealerships
  viewAllDealershipsListener();
  viewVehicle();
};

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
  .catch(error => console.error('Error:', error))
}

let renderAllDealerships = function(json){
  let dealershipTemplateHTML = $("#dealerships-template").html();
  let compiledTemplate = Handlebars.compile(dealershipTemplateHTML);
  let readyHTML = compiledTemplate(json);
  $("main")[0].innerHTML  = readyHTML;
}

$(function(){
  if ($(".application.welcome").length > 0){
    $(".application.welcome").ready(function(){
      Handlebars.registerPartial("dealershipPartial", $("#dealership-template").html())
    })
  }
})

$(function(){
  let page = $(".vehicles.index")
  if(page.length > 0){
    Handlebars.registerHelper("vehicleStatus", function(){
      return this.dealership_vehicle.is_lot_ready === true ? "Lot ready" : "In repair"
    })
  }
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



