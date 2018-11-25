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
            clearElement(input1);
            clearElement(input2);
            inputlabel1.innerHTML = "ZIP Code 1";
            inputlabel2.innerHTML = "ZIP Code 2";
            break;
        case "State":
            clearElement(input1);
            clearElement(input2);
            inputlabel1.innerHTML = "State 1";
            inputlabel2.innerHTML = "State 2";
            break;
        case "Restaurant":
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

