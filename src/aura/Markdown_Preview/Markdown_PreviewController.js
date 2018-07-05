({
	doInit : function(component, event, helper) {
		var recordId = component.get("v.recordId");
		var action = component.get("c.getPostContent");

		action.setParams({
				"recordId": recordId
		});
		action.setCallback(this, function(response) {
				var state = response.getState();

				if (state === "SUCCESS") {
					var recordContent = response.getReturnValue();
					component.find("formTextArea").set("v.value",recordContent);
					if (recordContent != null){
						component.set("v.markdownPreview", marked(recordContent));
					}
				}
				else {
					console.log("Failed with state: " + state);
				}
		});
			$A.enqueueAction(action);
	},
	onTextChange: function(component, event, helper){
			var recordContent = component.find("formTextArea").get("v.value");
			if (recordContent != null){
				component.set("v.markdownPreview", marked(recordContent));
			}

  },
	onFocus: function (component, event, helper){
		var recordId = component.get("v.recordId");
		helper.shortCuts(component, event);
		helper.save(component, event, recordId);
	},
	onFocusOut: function(component, event, helper){
		var intervalId = component.get("v.intervalId");
		clearInterval(intervalId);
	}
})
