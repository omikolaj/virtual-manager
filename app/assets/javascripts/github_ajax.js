let attachGithubListeners = function(){
    //createIssueListener() 
    
}

let createIssueListener = function(){
    //$("form#js-new-issue").on("submit", submitIssueForThisRepo)
}

class GithubIssue{
    constructor(attr){
        this.title = attr.title
        this.body = attr.body
        this.url = attr.html_url
        this.author = attr.user.login
        this.avatar = attr.user.avatar_url;
        this.handlebarsRegistration = ()=>Handlebars.registerPartial("issuePartial", $("#issue-template").html())
        this.handlebarsRegistration();
    }
}

let rednerNewIssuesDiv = function(collection){return template(collection)}

let createIssuesReadyTemplate = function(){
  this.templateSource = $("#issues-template").html()
  this.template = Handlebars.compile(this.templateSource)
}

let resetIssueForm = function(){
    $("#issue-title").val('');
    $("#issue-body").val('');
  }
  
let successOnIssue = function(resp){
    GithubIssue.prependIssue(resp)
  }
  
  GithubIssue.prependIssue = function(resp){   
      let issue = new Array(new GithubIssue(resp))
      createIssuesReadyTemplate()
      const githubDiv = rednerNewIssuesDiv(issue)
      $("#issues-display").prepend(githubDiv);
  }

  appendAllIssues = function(issues){
    createIssuesReadyTemplate()
    const githubDiv = rednerNewIssuesDiv(issues);
    $("#issues-display").html('')
    $("#issues-display").append(githubDiv);
  }

let formDataForIssue = function(form){
  let $form = $(form)
  let data = {
    action: $form.attr("action"),
    issue: {
      title: $form.find("#issue-title").val(),
      body: $form.find("#issue-body").val()
    }
  }
  return data;
}

let checkIssuesDiv = () => !$(".repo-issue").text().length>0 ? false : true

let checkAnyOpen = function(resp){
  if(checkIssuesDiv()){return false;}
  if(!resp.length>0){
    if($("#js-no-open-issues").text().indexOf("There are no open issues")){
      $("#js-issues-msg").append("<h3 id='js-no-open-issues'>There are no open issues</h3>")
      $("#js-no-open-issues").hide();
    }
    $("#js-no-open-issues").show().delay(3000).fadeOut();
  }
}

let hasErrors = function(data){  
  if(data.issue.title===''){
    if($("#js-validation").text().indexOf("Title is required")){
      $("#js-issues-msg").append("<h3 id='js-validation'>Title is required</h3>")
      $("#js-validation").hide();
    }
    $("#js-validation").show().delay(3000).fadeOut();
    return true;
  }
}

// This request is going through my rails backend server, creating a new GithubService object to make a call GitHub API returning JSON
submitIssueForThisRepo = function(form){
    let data = formDataForIssue(form)
    if(hasErrors(data)){return false;}
    fetch(data.action, {
        method: "POST",
        body: JSON.stringify(data.issue),
        credentials: 'same-origin',
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content'),
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        }
    })
    .then(handleErrors)
    .then(resp=>resp.json())
    .then(json=>successOnIssue(json))
    .then(resetIssueForm)
    .catch(displayIfAnyErrors)
}

/*
//This works as well. keeping it for reference for now
submitIssueForThisRepo = function(obj){
    //e.preventDefault()
    let $form = $(obj)
    let action = $form.attr("action")
    let params = $form.serialize()
    $.ajax({
        url: action,
        data: params,
        dataType: 'json',
        method: 'POST'
    })
    .success(GithubIssue.success)
    .error(GithubIssue.error)    
}
*/

let checkButtonProperties = function(btn){  
  let ajax = false;
  if(btn.attr('data') == '1'){
    ajax = modifyButtonText(btn);    
  }
  return ajax; 
}

let modifyButtonText = function(btn){
  let issuesDiv = $("#issues-display")
  if(btn.text() === "Collapse"){
    issuesDiv.hide();
    btn.text("Show open issues")
  }else if(btn.text() === "Show open issues"){
    issuesDiv.show();
    btn.text("Collapse")    
  }
  return true; 
}

// Retrieving all of the open issues making a fetch call directly from front end JavaScript
showOpenIssues = function(){
  if(checkButtonProperties($("#js-show-issues"))){return false;}
  fetch(`https://api.github.com/repos/omikolaj/hello-world/issues?state=${encodeURIComponent('open')}`,{
    credentials: 'same-origin',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
      }
    })
    .then(handleErrors)
    .then(resp=>resp.json())
    .then(issuesOnSuccess)
    .catch(displayIfAnyErrors) 
}

let showOpenIssuesFired = function(issues){
  if(issues === undefined || issues.length===0){return false;}
  let issueDiv = $("#js-show-issues")
  issueDiv.attr('data','1');
  $("#js-show-issues").text("Collapse")
 };

let issuesOnSuccess = function(issues){
  checkAnyOpen(issues)
  showOpenIssuesFired(issues)
  if(issues === undefined || issues.length===0){return false;}
    let issuesArr = []  
    issues.forEach((item, index, array)=>issuesArr.push(new GithubIssue(item)))
    appendAllIssues(issuesArr)
  }

  forkRepo = function(){
    fetch("/fork", {
      method: "post", 
      credentials: 'same-origin',     
      headers:{
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content'),
        'Accept': 'application/json'        
      }
    })
    .then(handleErrors)
    .then(resp=>resp.json())
    .then(success)
    .catch(displayIfAnyErrors)
  }

  let success = function(resp){
    switch(resp.fork===true){
      case true:
      onSuccesfulFork()
      break;
      case false:
      onFailedFork()
      break;
    }    
  }

  let onSuccesfulFork = function(){
      if($("#js-info-msg").text().trim().length === 0){
        $("#js-info-msg").append("<h3>Success</h3>").delay(3000).fadeOut()
      }else{
        $("#js-info-msg").show().delay(3000).fadeOut();
      }
    }  

  let onFailedFork = function(){

      if($("#js-info-msg").text().trim().length === 0){
        $("#js-info-msg").append("<h3>Something went wrong, you may have already forked this repo</h3>").delay(3000).fadeOut()
      }else{
        $("#js-info-msg").show().delay(3000).fadeOut();
      }
    }
  
   






