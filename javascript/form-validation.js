function validateForm() {
    var x = document.forms["signupform"]["password"].value;
    if (x.length < 8) {
        alert("Password must have atleast 8 characters!");
        return false;
    }
}
