let attachGithubListeners = function(){
    createIssueListener() 
}

let createIssueListener = function(){
    $("form#js-new-issue").on("submit", submitIssueForThisRepo)
}

class Github{
    constructor(){

    }
}

class GithubIssue{
    constructor(attr){
        this.title = attr.title
        this.body = attr.body
        this.author = attr.user.login
        this.avatar = attr.user.avatar_url
    }
    createReadyTemplate(){
        this.templateSource = $("#issue-template").html()
        this.template = Handlebars.compile(this.templateSource)
    }
    rednerNewIssueDiv(){
        debugger
        return this.template(this)
    }

}

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
    .success(Github.appendIssue)
    .error(Github.error)    
}

Github.appendIssue = function(resp){    
    var issue = new GithubIssue(resp)
    issue.createReadyTemplate()
    const githubDiv = issue.rednerNewIssueDiv()
    debugger
    $("#issues-display").append(githubDiv);
}

Github.error = function(e){
    debugger
}
