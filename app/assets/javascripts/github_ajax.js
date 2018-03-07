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
let resetForm = function(){
    $("#issue-title").empty();
    $("#issue-body").empty();
  }
  
let success = function(resp){
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
/*
let $form = $(this)
let action = $form.attr("action")
let title = $("#issue-title").val()
let body= $("#issue-body").val()
let params = $form.serialize()
*/
submitIssueForThisRepo = function(obj){
    let form = $(obj)
    fetch('/create_issue',{
        method: "POST",
        body: JSON.stringify({title: "title"}),
        credentials: 'same-origin',
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content'),
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        }
    })
    .then(handleErrors)
    .then(resp=>resp.json())
    .then(json=>success(json))
    .then(resetForm)
    .catch(displayIfAnyErrors)
}

/*
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



