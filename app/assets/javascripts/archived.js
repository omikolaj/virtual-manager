
/*
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
*/

/*
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

/*
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
*/


/*
let resetIssueForm = function(){
    $("#issue-title").val('');
    $("#issue-body").val('');
  }
*/

/*
let successOnIssue = function(resp){
    GithubIssue.prependIssue(resp)
  }
*/

/*
  GithubIssue.prependIssue = function(resp){   
      let issue = new Array(new GithubIssue(resp))
      createIssuesReadyTemplate()
      const githubDiv = rednerNewIssuesDiv(issue)
      $("#issues-display").prepend(githubDiv);
  }
*/


/*
forkRepo = function(){
  debugger
  fetch(`https://api.github.com/repos/omikolaj/hello-world/forks`, {
    method: 'post',
    headers: {
      'Authorization': `token 10aeb1218a0b4bc308fded754d3bb263dd1cc5aa`
    }
  })
  .then(resp=>resp.json())
  .then(function(e){
    })  
  }
  */

  /*
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
    */
