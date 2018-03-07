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
        this.avatar = attr.user.avatar_url
    }
    createIssueReadyTemplate(){
        this.templateSource = $("#issue-template").html()
        this.template = Handlebars.compile(this.templateSource)
    }
    rednerNewIssueDiv(){return this.template(this)
    }
}

let resetIssueForm = function(){
    $("#issue-title").val('');
    $("#issue-body").val('');
  }
  
let successOnIssue = function(resp){
    GithubIssue.appendIssue(resp)
  }
  
  GithubIssue.appendIssue = function(resp){    
      var issue = new GithubIssue(resp)
      issue.createIssueReadyTemplate()
      const githubDiv = issue.rednerNewIssueDiv()
      $("#issues-display").append(githubDiv);
  }
  
  GithubIssue.error = function(error){
    debugger
    console.error('Error:', error)
  }

let dataForIssue = function(obj){
  let $form = $(obj)
  let data = {
    action: $form.attr("action"),
    issue: {
      title: $form.find("#issue-title").val(),
      body: $form.find("#issue-body").val()
    }
  }
  return data;
}

submitIssueForThisRepo = function(obj){
    let data = dataForIssue(obj)
    debugger
    fetch(data.action,{
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

/* This works as well. keeping it for reference for now
submitIssueForThisRepo = function(e){
    e.preventDefault()
    let $form = $(this)
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



