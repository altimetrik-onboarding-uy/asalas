({
	save : function(component, event, recordId, recordContent) {
		var currentIntervalId = setInterval(function() {
			var action = component.get("c.autoSave");
			action.setParams({
					"recordId": recordId,
					"recordContent": recordContent
			});
			action.setCallback(this, function(response) {
					var state = response.getState();

					if (state === "SUCCESS") {
						component.set("v.saved", "Your content has been saved!");
						component.set("v.intervalId", currentIntervalId);
					}
					else {
						console.log("Failed with state: " + state);
					}
			});
				$A.enqueueAction(action);
		}, 3000);
	}
})
