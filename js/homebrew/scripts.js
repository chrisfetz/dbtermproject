//A list of state abbreviations for the user input
var stateAbbrList = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", 
                "DE", "FL", "GA", "HI", "ID", "IL", "IN", 
                "IA", "KS", "KY", "LA", "ME", "MD", "MA", 
                "MI", "MN", "MS", "MO", "MT", "NE", "NV", 
                "NH", "NJ", "NM", "NY", "NC", "ND", "OH", 
                "OK", "OR", "PA", "RI", "SC", "SD", "TN", 
                "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"];

//A list of state names for the user input
var stateNameList = ["Alabama", "Alaska", "Arizona", "Arkansas", "California",
                     "Colorado", "Connecticut", "Delaware", "Florida", "Georgia",
                     "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky",
                     "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan",
                     "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada",
                     "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina",
                     "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvia", "Rhode Island",
                     "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia",
                     "Washington", "West Virginia", "Wisconsin", "Wyoming"];

//A list of the restaurants we're using
var restaurantNameList = ["Subway", "McDonald's", "Burger King", "Taco Bell", "Pizza Hut", "Wendy's",
                          "Domino's", "KFC", "Dairy Queen", "Arby's", "Sonic Drive-In", "Hardee's", 
                          "Jimmy John's", "Jack in the Box", "Chick-fil-A", "Chipotle", "Panda Express",
                          "Carl's Jr.", "Five Guys", "Whataburger"];

inputsdiv = document.getElementById("inputs-here");
inputsdefault = getDefaults();

//Gets the value of the radio button that was clicked.
function getValue (myRadio) {

    var value;
    myRadio = document.getElementsByName(myRadio.name);
    for (var i = 0, length = myRadio.length; i < length; i++) {
        if (myRadio[i].checked)  {
            //do whatever you want with the checked radio
            value = myRadio[i].value;

            //only one radio can be logically checked, don't check the rest
            break;
        }
    }
    return value;
}

//handle radio button clicks and change the frontend as necessary
function radioClick (myRadio) {
    //get value of radio that was clicked
    value = getValue(myRadio);

    //get dom elements that may be changed
    var input1 = document.getElementById("textinput1");
    var input2 = document.getElementById("textinput2");
    var inputlabel1 = document.getElementById("textinputlabel1");
    var inputlabel2 = document.getElementById("textinputlabel2");
    var inputsdiv = document.getElementById("inputs-here");
    var zipradio = document.getElementById("zipradio");

    switch (value) {
        case "One":
            zipradio.disabled = false;
            showElement(inputsdiv);
            showElement(inputlabel1);
            showElement(input1);
            hideElement(inputlabel2);
            hideAndClearElement(input2);
            break;
        case "Two":
            zipradio.disabled = false;
            showElement(inputsdiv);
            showElement(inputlabel1);
            showElement(input1);
            showElement(inputlabel2);
            showElement(input2);
            break;
        case "All":
            zipradio.disabled = true;
            zipradio.checked = false;
            hideElement(inputsdiv);
            hideElement(inputlabel1);
            hideAndClearElement(input1);
            hideElement(inputlabel2);
            hideAndClearElement(input2);
            break;
        case "ZIP":
            inputsdiv.parentNode.replaceChild(inputsdefault, inputsdiv);
            clearElement(input1);
            clearElement(input2);
            inputlabel1.innerHTML = "ZIP Code 1";
            inputlabel2.innerHTML = "ZIP Code 2";
            break;
        case "State":
            input1.parentNode.replaceChild(generateStateSelect(), input1);  
            clearElement(input1);
            clearElement(input2);
            input1.parentNode.replaceChild(generateStateSelect(), input1);
            input2.parentNode.replaceChild(generateStateSelect(), input2);
            inputlabel1.innerHTML = "State 1";
            inputlabel2.innerHTML = "State 2";
            break;
        case "Restaurant":
            inputsdiv.parentNode.replaceChild(inputsdefault, inputsdiv);
            clearElement(input1);
            clearElement(input2);
            inputlabel1.innerHTML = "Restaurant 1";
            inputlabel2.innerHTML = "Restaurant 2";
            break;
        default:
            alert("Something went wrong. Please refresh the page.");
    }
}

//hides an element and changes its value to default
function hideAndClearElement(myElement){
    hideElement(myElement);
    clearElement(myElement);
}

//hides an element from view
function hideElement(myElement){
    myElement.style.display = "none";
}

//shows a previously hidden element
function showElement(myElement){
    myElement.style.display = "block";
}

//changes the value of an element to default
function clearElement(myElement){
    myElement.value = "";
}

//generates selects for states
function generateStateSelect () {

    var myDiv = document.createElement('div');

    //code from stackoverflow, credits to the author Kappa
    //Create and append 
    var selectList = document.createElement("select");
    selectList.id = "mySelect";
    myDiv.appendChild(selectList);

    //Create and append the options
    for (var i = 0; i < stateNameList.length; i++){
        var option = document.createElement("option");
        option.value = stateAbbrList[i];
        option.text = stateNameList[i];
        selectList.appendChild(option);
    }

    return myDiv;
}

function restoreDefaults () {
    
}

function getDefaults () {
    var inputshere = document.getElementById("inputs-here");
    return inputshere;
}

function generateInput(count, type) {
    var inputGroupClasses = "input-group input-group-sm mb-3";
    var prependClasses = "input-group-prepend";
    var labelClasses = "input-group-text";
    var inputTypes = ["text", "select"];
    var selectionTypes = ["ZIP Code", "State", "Restaurant"];
    var displayTypes = ["block", "none"];
    var inputclass = "form-control";
    //aria-label="Text input 2" 
    //aria-describedby="inputGroup-sizing-sm"

    var inputsdiv = document.createElement("div");
    for (var i = 0; i < count; i++){
        var inputspart = document.createElement("div");
        inputspart.class = inputGroupClasses;
    }

}