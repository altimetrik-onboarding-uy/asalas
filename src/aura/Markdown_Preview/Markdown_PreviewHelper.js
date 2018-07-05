({
	save : function(component, event, recordId) {
		var currentIntervalId = setInterval(function() {
			var recordContent = component.find("formTextArea").get("v.value");
			var action = component.get("c.autoSave");
			action.setParams({
					"recordId": recordId,
					"recordContent": recordContent
			});
			action.setCallback(this, function(response) {
					var state = response.getState();
					if (state === "SUCCESS") {
						var recordStatus = response.getReturnValue();

						if (recordStatus == "Draft"){
							component.set("v.saved", "Your content has been saved!");
							component.set("v.intervalId", currentIntervalId);
						}
						else {
							component.set("v.saved", "Your content can't be saved, please change your STATUS to Draft first, to be able to save it");
						}
					}
					else {
						console.log("Failed with state: " + state);
					}
			});
				$A.enqueueAction(action);
		}, 3000);
	},
	shortCuts: function(component, event, recordId) {
		var map = {};
		onkeydown = onkeyup = function(e){
			var recordContent = component.find("formTextArea").get("v.value");
			e = e || event;
			map[e.key] = e.type == 'keydown';

			if(map["Control"] && map["Shift"] && (map["L"] || map["l"])){
				e.preventDefault();
				component.find("formTextArea").set("v.value",recordContent+"``````");
			}else if(map["Control"] && (map["L"] || map["l"])){
				e.preventDefault();
				component.find("formTextArea").set("v.value",recordContent+"``");
			}else if(map["Control"] && (map["I"] || map["i"])){
				e.preventDefault();
				component.find("formTextArea").set("v.value",recordContent+"**");
			}else if(map["Control"] && (map["B"] || map["b"])){
				e.preventDefault();
				component.find("formTextArea").set("v.value",recordContent+"****");
			}
		}
	}
})
