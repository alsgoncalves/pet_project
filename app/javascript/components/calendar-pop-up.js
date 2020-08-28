function calendarPopUp() {
  let calendarDays = document.querySelectorAll("table.table-striped tbody tr td.day");

  // Display in a pop-up box the selected day's events info
  Array.prototype.forEach.call (calendarDays, function(selectedDay) {
    selectedDay.addEventListener("click", function() {
      // Populate the pop-up box with the events info
      PopulateEventInfo(selectedDay.getAttribute("data-day"),
                        selectedDay.getAttribute("data-month"),
                        selectedDay.getAttribute("data-year"));

      // Make the pop-up box visible
      let eventPopUp = document.getElementById("content-event-popup");
      if (eventPopUp.style.visibility == "hidden") {
        eventPopUp.style.visibility = "visible";
        eventPopUp.style.opacity = "1";
      }
    });
  });

  // If the user clicks outside of the calendar or the calendar pop-up then close the pop-up
  window.addEventListener('click', function(event) {
    let isInside = document.getElementById('events_calendar').contains(event.target) ||
                   document.getElementById('content-event-popup').contains(event.target);
    if (!isInside) {
      let eventPopUp = document.getElementById("content-event-popup");
      eventPopUp.style.visibility = "hidden";
      eventPopUp.style.opacity = "0";
    }
  });

  const monthNames =
    [
      "Jan", "Feb", "Mar", "Apr", "May", "June",
      "July", "Aug", "Sept", "Oct", "Nov", "Dec"
    ];

  // Use the gem "gon" in order to call the Pages Controller variable "calendar_events"
  let eventsToDisplay = gon.calendar_events;

  // Populate the pop-up box with the events info
  function PopulateEventInfo(day, month, year) {
    let dateString = `${zeroPaddedNumber(year, 4)}-${zeroPaddedNumber(month)}-${zeroPaddedNumber(day)}`;
    let selectedDateEvents = eventsToDisplay[dateString];
    let boxContent = document.getElementById("content-event-popup");

    // Clean the pop-up box content; leave the basic layout
    boxContent.innerHTML = `<div id="headers-event-popup">
                              <h6 id="date-event-popup">${monthNames[month - 1]} ${day}</h6>
                              <ul class="nav nav-tabs"></ul>
                            </div>
                            <div class="tab-content"></div>`;

    let eventContent = document.querySelector("div#content-event-popup div.tab-content");

    // The pop-up box format will depend on the presence, or not, of events on the selected date
    if (selectedDateEvents == null || selectedDateEvents.length == 0) {
      eventContent.innerHTML = '<p>Nothing happening this day</p>';

    } else {
      for (let i = 0; i < selectedDateEvents.length; i++) {
        let selectedEvent = selectedDateEvents[i];

        // Create the navigation headers
        let listLi = document.createElement('li');
        listLi.className = ( i == 0 ? 'nav-item active': 'nav-item');

        let anchor = document.createElement('a');
        anchor.className = ( i == 0 ? 'nav-link active show': 'nav-link');
        anchor.setAttribute('data-toggle', 'tab');
        anchor.setAttribute('href', `#event${i + 1}`);
        anchor.innerHTML = `<i class="${selectedEvent.org_cat_icon}"></i>`;

        listLi.appendChild(anchor);
        document.querySelector("div#content-event-popup ul.nav.nav-tabs").appendChild(listLi);

        // Create the Events content
        let contentDiv = document.createElement('div');
        contentDiv.id = `event${i + 1}`;
        contentDiv.className = (i == 0 ? "tab-pane fade active in show" : "tab-pane fade");

        contentDiv.appendChild(paraCreator(selectedEvent.title))        // Appends the title
        contentDiv.appendChild(paraCreator(selectedEvent.location));    // Appends the location
        contentDiv.appendChild(paraCreator(selectedEvent.time));        // Appends the time
        contentDiv.appendChild(paraCreator(selectedEvent.part_count));  // Appends the num of participants

        eventContent.appendChild(contentDiv);
      }
    }
  }

  // If a number has less digits than a certain number, then padd it with zeros
  function zeroPaddedNumber(num, digits = 2) {
    return ("0000" + num).slice(-digits);
  }

  // Returns a new paragraph element with the functions argument as its content
  function paraCreator(content) {
    let contentPara = document.createElement('p');
    contentPara.innerHTML = content;
    return contentPara;
  }
}

export { calendarPopUp };
