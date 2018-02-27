$(()=>attachListeners);

let attachListeners = function(){
  //Attach click event to display all dealerships
  viewAllDealershipsListener;
};

let viewAllDealershipsListener = $(document).on("click", "#all-dealerships", getAllDealerships);

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

let handleErrors = function(res){
  if (res.ok){
    return res
  }
  throw Error(res.statusText);
}

$(function(){
  Handlebars.registerPartial("dealershipPartial", $("#dealership-template").html())
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
})

