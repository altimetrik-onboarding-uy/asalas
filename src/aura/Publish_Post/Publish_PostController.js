({
	closeBtn : function(component, event, helper) {
		// Close the action panel
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
	},
	doInit : function(component, event, helper) {
			var approvalMessage 									= "Congratz!, Your Post was Published!.";
			var rejectionMessage_alreadyPublished = "Your Post is already Published, no needs to do it again";
			var rejectionMessage_notReadyStatus	  = "Your post has to be approved by your manager before been able to publish this post. Please first Submit your post for approval."
			var recordId 													= component.get("v.recordId");
			var action 														= component.get("c.managePublishPost");
			action.setParams({
					"recordId": recordId,
			});
			action.setCallback(this, function(response) {
					var state = response.getState();

					if (state === "SUCCESS") {
						var recordStatus = response.getReturnValue();

						if(recordStatus[0] == "Published" && recordStatus[1] == "Published"){
							component.set("v.message", rejectionMessage_alreadyPublished);
						}
						else if(recordStatus[0] == "Ready" && recordStatus[1] == "Published"){
							component.set("v.message", approvalMessage);
						}
						else{
							component.set("v.message", rejectionMessage_notReadyStatus);
						}
					}
					else {
						console.log("Failed with state: " + state);
					}
			});
			$A.enqueueAction(action);
}
})