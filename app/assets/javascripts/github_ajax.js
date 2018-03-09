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

// This request is going through my rails backend server, creating a new GithubService object to make a call GitHub API returning JSON
submitIssueForThisRepo = function(form){
    let data = formDataForIssue(form)
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
    .then(showOpenIssuesFired)
    .catch(displayIfAnyErrors) 
}

let showOpenIssuesFired = function(){
  let issueDiv = $("#js-show-issues")
  issueDiv.attr('data','1');
  $("#js-show-issues").text("Collapse")
 };

let issuesOnSuccess = function(issues){
  let issuesArr = []  
  issues.forEach((item, index, array)=>issuesArr.push(new GithubIssue(item)))
  appendAllIssues(issuesArr)
}



