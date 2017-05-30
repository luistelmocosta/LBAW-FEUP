function validateForm() {
    var x = document.forms["signupform"]["password"].value;
    if (x.length < 8) {
        alert("Password must have atleast 8 characters!");
        return false;
    }
}

function validateQuestionForm() {
    var x = document.forms["questioncommentform"]["comment"].value;
    if (x.length < 8) {
        alert("Password must have atleast 8 characters!");
        return false;
    }
}

function validateAnswerForm() {
    var x = document.forms["answercommentform"]["comment"].value;
    if (x.length < 8) {
        alert("Password must have atleast 8 characters!");
        return false;
    }
}
