Rails Project NOTES Virtual Dealership Manager

1. Research how to generate scaffolding for Rails App, (Not rails g scaffold). Rails skeleton app. 

2. Implement Omniauth github strategy (gem "omniauth" and gem "omniauth-github")

3. Implement custom authentication system. Using current_user ||= User.find_by(:id => session[:id]) pattern.

4. Implement custom authorization. (Manager and employee priviliges, "perhaps customers?"). Refer to todomvc-authorization lab Avi did for how to properly implement authorization.

5. Use before_action on controllers to authenticate and autherize when needed. User before_action on controllers to retrieve models from the database for our views. This will keep controllers slim and DRY.

6. Implement meta-programming for dynamically defining and dispatching methods. Refer to "rails-amusement-park-lab" in model Rides as well as todomvc-authorization.

7. Implement partials. Make sure to use rails collection syntax for partials. Revisit the lab to refresh memory on this. 

8. Implement Views helpers. Visit "TodoMVC4" video, Avi does this. Implement builders for lis. Should be easy when figured out what needs to be displayed.

9. Of course custom attribute writer in the model class.

10. Model level filter method, use ActiveRecord query selectors, perhaps the scope macro from the docs. this should allow for filtering the car model for specific year

11. Good validations and descriptive messages when validation fails so user knows what to fix. Use flash[:notice] to implement this in the views. this will highlight the field that needs to be fixed or that failed validation.

12. Nexted routes. Namespace perhaps render different views for managers when editing inventory.
