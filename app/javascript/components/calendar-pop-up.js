function calendarPopUp() {
  let calendarDays = document.querySelectorAll("table.table-striped tbody tr td.day");

  Array.prototype.forEach.call (calendarDays, function(selectedDay) {
    selectedDay.addEventListener("click", function() {
      // Populate the pop-up box with the relevant information
      PopulateEventInfo(selectedDay.getAttribute("data-day"),
                        selectedDay.getAttribute("data-month"),
                        selectedDay.getAttribute("data-year"));

      // Make the pop-up box visible
      let eventPopUp = document.getElementById("content-event-popup");
      if (eventPopUp.style.visibility == "hidden") {
        eventPopUp.style.visibility = "visible";
      }
      });
  });

  window.addEventListener('click', function(event) {
    let isInside = document.getElementById('events_calendar').contains(event.target) ||
                   document.getElementById('content-event-popup').contains(event.target);
    if (!isInside) {
      let eventPopUp = document.getElementById("content-event-popup");
      eventPopUp.style.visibility = "hidden";
    }
  });

  const monthNames =
    [
      "Jan", "Feb", "Mar", "Apr", "May", "June",
      "July", "Aug", "Sept", "Oct", "Nov", "Dec"
    ];

  // Import variable from the Rails Controller
  let eventsToDisplay = gon.calendar_events;

  function PopulateEventInfo(day, month, year) {
    // Create the layout of the pop-up box
    let selectedDateEvents = eventsToDisplay[`${zeroPaddedNumber(year, 4)}-${zeroPaddedNumber(month)}-${zeroPaddedNumber(day)}`]
    let boxContent = document.getElementById("content-event-popup");

    boxContent.innerHTML = `<div id="headers-event-popup">
                              <h6 id="date-event-popup">${monthNames[month - 1]} ${day}</h6>
                              <ul class="nav nav-tabs"></ul>
                            </div>
                            <div class="tab-content"></div>`;

    // The pop-up box format will depend if it a certain date has events or not
    if (selectedDateEvents == null || selectedDateEvents.length == 0) {
      document.querySelector("div#content-event-popup div.tab-content").innerHTML = '<p>Nothing happening this day</p>';

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

        // Create the content
        let contentDiv = document.createElement('div');
        contentDiv.id = `event${i + 1}`;
        contentDiv.className = (i == 0 ? "tab-pane fade active in show" : "tab-pane fade");

        let contentParaTitle = document.createElement('p');
        contentParaTitle.innerHTML = selectedEvent.title;
        contentDiv.appendChild(contentParaTitle);

        let contentParaLocation = document.createElement('p');
        contentParaLocation.innerHTML = selectedEvent.location;
        contentDiv.appendChild(contentParaLocation);

        let contentParaTime = document.createElement('p');
        contentParaTime.innerHTML = selectedEvent.time;
        contentDiv.appendChild(contentParaTime);

        let contentParaPart = document.createElement('p');
        contentParaPart.innerHTML = selectedEvent.part_count;
        contentDiv.appendChild(contentParaPart);

        document.querySelector("div#content-event-popup div.tab-content").appendChild(contentDiv);
      }
    }
  }

  function zeroPaddedNumber(num, digits = 2) {
    return ("0000" + num).slice(-digits);
  }
}

export { calendarPopUp };
