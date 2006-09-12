var phokus = new Object;

phokus = {
	init: function() {
		this.addCustomizer();
		this.initToggles();
		this.linkIcons();
	},
	initToggles: function() {
		// Add toggle to sidebar panels
		var pHeadings = $("sidebar").getElementsByTagName("h3");
		Element.cleanWhitespace($("sidebar"));
		for (var i = 0, j; j = pHeadings[i]; i++) {
			this.addToggle(j, j.parentNode);
		}

		// Add toggle to search panel
		var sPanel = $("search");
		var sHead = sPanel.getElementsByTagName("label")[0];
		this.addToggle(sHead, sPanel);

		// Add toggle to post panels
		var panels = document.getElementsByClassName("post");
		Element.cleanWhitespace($("main"));
		for (var i = 0, j; j = panels[i]; i++) {
			j.heading = j.getElementsByTagName("h2")[0];
			this.addToggle(j.heading, j);
		}
	},
	addToggle: function(pHeader, pContent) {
		var self = this;
		var hOff = "toggle-off";
		var hOn = "toggle-on";
		var cOff = "toggle-content-off";
		var cOn = "toggle-content-on";
		var widget = document.createElement("span");
	
		Element.addClassName(pHeader, hOn);
		widget.title = "Toggle this panel";
		widget.className = "toggle";
	
		widget.onclick = function() {
			self.swapClass(pHeader, hOff, hOn);
			self.swapClass(pContent, cOff, cOn);
		}
	
		pHeader.appendChild(widget);
	},
	swapClass: function(el, a, b) {
		var hasClass = Element.hasClassName(el, a);
		var del = hasClass ? a : b;
		var add = hasClass ? b : a;

		Element.removeClassName(el, del);
		Element.addClassName(el, add);
	},
	addCustomizer: function() {
		var html = '<ul>';
		html += '<li id="layout-001-btn" title="Sidebar on left"></li>';
		html += '<li id="layout-002-btn" title="Sidebar on right"></li>';
		html += '</ul>';

		var c = document.createElement("div");
		c.id = "customize";
		c.innerHTML = html;
		$("sidebar").insertBefore(c,$("search"));

		$("layout-001-btn").onclick = function() {
			$('page').className = 'layout-001';
			return false;
		}
		$("layout-002-btn").onclick = function() {
			$('page').className = 'layout-002';
			return false;
		}
	},
	linkIcons: function() {
		var l = document.getElementsByTagName("a");
		var regex = '/' + document.location.hostname + '/';

		for (var i = 0, j; j = l[i]; i++) {
			if (j.getElementsByTagName("img").length == 0) {
				if (!j.href.match(regex)) {
					j.externalLink = true;
				}
				if (j.href == '') {
					j.externalLink = false;
				}
				if (path = j.href.split(".")) {
					var ext = path[path.length - 1].substr(0,3);
				}
				switch(ext) {
					case 'xml':
					case 'rss':
						j.linkIcon = "ico-feed";
						break;
				}
				if (j.externalLink && !j.linkIcon) {
					j.linkIcon = "ico-external";
				}
				if (j.linkIcon) {
					j.innerHTML = '<span class="link-ico"><span class="' + j.linkIcon + '"></span></span>' + j.innerHTML;
				}
			}
		}
	},
	closeSearch: function() {
		$('search-results').innerHTML = '';
		$('q').value = '';
	}
}
