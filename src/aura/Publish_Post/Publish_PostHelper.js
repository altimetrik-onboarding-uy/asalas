({
	getPostStatus : function(component, recordId) {
        var action = component.get("c.getStatus");

			  action.setParams({
            "recordId": recordId,
        });
        action.setCallback(this, function(response) {
            var state = response.getState();

            if (state === "SUCCESS") {
							component.set("v.recordStatus", response.getReturnValue());
            }
            else {
            	console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
	}
})