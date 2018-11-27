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

//get dom elements that may be changed
var input1 = document.getElementsByName("textinput1");
var input2 = document.getElementByName("textinput2");

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

function populateStates(){
    var selects = document.getElementsByTagName("select");
    for (var i = 0; i < selects.length; i++){
        populateState(selects[i]);
    }
}

function populateState (input) {
    for(var i = 0; i < stateAbbrList.length; i++){
        var opt = document.createElement("option");
        opt.value= stateAbbrList[i];
        opt.innerHTML = stateNameList[i]; // whatever property it has

        // then append it to the select element
        input.appendChild(opt);
    }
}

function populateRestaurants(){
    var selects = document.getElementsByTagName("select");
    for (var i = 0; i < selects.length; i++){
        populateRestaurant(selects[i]);
    }
}

function populateRestaurant (input) {
    for(var i = 0; i < restaurantNameList.length; i++){
        var opt = document.createElement("option");
        opt.value= restaurantNameList[i];
        opt.innerHTML = restaurantNameList[i]; // whatever property it has

        // then append it to the select element
        input.appendChild(opt);
    }
}