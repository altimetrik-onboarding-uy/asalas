({
	getPostStatus : function(component, recordId) {
        var action = component.get("c.getStatus");

			  action.setParams({
            "recordId": recordId,
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
						console.log("pelota");
            if (state === "SUCCESS") {
							component.set("v.recordStatus", response.getReturnValue());
            }
            else {
            	console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
	},
	setPostStatus: function (component,recordId, status){
		var recordStatus = component.get("v.recordStatus");
		var action = component.get("c.postStatusBuilder");

		action.setParams({
				"recordId": recordId,
				"recordStatus":status
		});
		action.setCallback(this, function(response) {
				var state = response.getState();

				if (state === "SUCCESS") {
					console.log("status was updated!");
				}
				else {
					console.log("Failed with state: " + state);
				}
		});
		$A.enqueueAction(action);
	}
})