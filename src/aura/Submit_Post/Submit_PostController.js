({
	closeBtn : function(component, event, helper) {
		// Close the action panel
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
	},
    doInit : function(component, event, helper) {
        var approvalMessage  = "Your Post was sent to your Manager for review.";
        var rejectionMessage = "Your Post is already Under Review, no needs to send it Again"
				var rejectionMessage_alreadyPublished = "Your Post is already Published, no needs for new Submit"
        var recordId 		 		 = component.get("v.recordId");

				var action = component.get("c.manageSubmitPost");
				action.setParams({
						"recordId": recordId,
				});
				action.setCallback(this, function(response) {
						var state = response.getState();

						if (state === "SUCCESS") {
							var recordStatus = response.getReturnValue();

							if (recordStatus[0] == "Published"){
			            component.set("v.message", rejectionMessage_alreadyPublished);
			        }
							else if (recordStatus[0] == "Under Review" && recordStatus[1] == "Under Review"){
			            component.set("v.message", rejectionMessage);
			        }
			        else{
			        	component.set("v.message", approvalMessage);
			        }
						}
						else {
							console.log("Failed with state: " + state);
						}
				});
				$A.enqueueAction(action);
	}
})