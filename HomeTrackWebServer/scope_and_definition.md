# Framework and language

Despite Javascript being more widely used in web development, this webserver will be developed in Python.

While it is understood the performance penalty for using Python, the performance requirement for this development is quite low, and the penalty it brings is negligible when compared to the upside of using a already know programming language.

As for the framework, both Django and Flask are good contenders with pros and cons. 
- Flask seems to be the most interesting from a developer perspective as it allows more freedom of implementation. Since this application will only be available in a local networks, security of the application should not be much of a concern. Flask should also be simpler to get to know.
- Django comes prepackaged with all the modules required, which makes it easier to implement and to maintain, but is more limiting regarding implementation of emerging technologies. Since it is more locked down, it is safer to deploy with the downside of having more information that need to be known.

For this project, **Flask will be used**, as it allows learning the underlying concepts which comes pre included into Django.

# Views
## Main view
The main view will show graphs. The graphs will show a plot of the measurements collected from the satellites. On each graph, the user will be able to change the time period, which will also affect the frequency of the measurements shown, and change the room/satellite shown in the graph, so it can be easier to compare measurements.

The will also be possible to hide/show the graphs, which will remain in the same state between accesses. This state will be kept in the browser as it will allow to learn about state saving methods (cookies, sessionStorage, JsonWebTokens).

## Settings view
In the settings view, the user will be able to change the way the system works. The user will be able to register new satellites and change the configuration for each satellite, changing:
- Update frequency
- Assigned room
- Assigned power circuit measured
- Upstream satellite

The user will also be able to change the layout of the home by adding rooms and power circuits.