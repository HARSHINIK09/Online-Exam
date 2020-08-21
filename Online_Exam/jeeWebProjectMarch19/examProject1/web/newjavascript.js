function myCheckEmail(email)
{
    if(email.value.length == 0)
    {
        alert("Plz enter email id");
        email.focus();
        
        return false;
    }
    
    if(email.value.indexOf('.') == -1  || email.value.indexOf('.') == 0 || email.value.indexOf('.') == email.value.length -1)
    {
        alert("Invalid email id");
        email.value = "";
        email.focus();
        
        return false;
    }
    
    if(email.value.indexOf('@') == -1  || email.value.indexOf('@') == 0 || email.value.indexOf('@') == email.value.length -1)
    {
        alert("Invalid email id");
        email.value = "";
        email.focus();
        
        return false;
    }
    
    return true;
}

function validateForm(username, sname, email, pwd, pwd2, hintq, hinta)
{
    
    if(username.value.length == 0)
    {
        alert("Plz enter user name");
        username.focus();
        
        return false;
    }
    
    if(sname.value.length == 0)
    {
        alert("Plz enter your name");
        sname.focus();
        
        return false;
    }
    
    var x = myCheckEmail(email);
    
    if(x == false)
        return false;
    
  
    if(pwd.value.length < 6)
    {
        alert("Password must be atleast six characters long");
        pwd.value = "";
        pwd.focus();
        
        return false;
    }
    
    
    if(pwd.value != pwd2.value)
    {
        alert("Passwords must match");
        pwd2.focus();

        return false;
    }
    
    if(hintq.value.length == 0)
    {
        alert("Plz enter the hint question");
        hintq.focus();
        
        return false;
    }
    
    if(hinta.value.length == 0)
    {
        alert("Plz enter the hint answers");
        hinta.focus();
        
        return false;
    }
    
    return true;
}