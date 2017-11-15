jQuery.sap.declare("lorum.app.viewer.ViewerListItem");
jQuery.sap.require("lorum.m.StandardListItem");

sap.m.StandardListItem.extend("lorum.app.viewer.ViewerListItem", {
    metadata: {
        library: "lorum.app.viewer",
        properties: {
            uniqueId: { type: 'string' },
            fullTitle: { type: 'string' }
        }
    },
    renderer: "lorum.m.StandardListItemRenderer"
});

lorum.app.viewer.ViewerListItem.prototype.onAfterRendering = function() {
    var self = this,
        $domRef = $(this.getDomRef()),
        hasTouch = lorum.common.hasTouch();

    // for tooltip
    $domRef.attr('title', this.getFullTitle());
    if (this.getUniqueId()) {
        $domRef.attr('data-lorum-uniqueId', this.getUniqueId());
    }

    if (hasTouch) {
        $domRef.bind('taphold', function(e) {
            self.showTooltipPopup();
        });
    }
};
