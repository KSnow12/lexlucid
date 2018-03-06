// Copyright (c) 2011 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// When the extension is installed or upgraded ...
chrome.runtime.onInstalled.addListener(function() {
  // Replace all rules ...
  chrome.declarativeContent.onPageChanged.removeRules(undefined, function() {
    // With a new rule ...
    chrome.declarativeContent.onPageChanged.addRules([
      {
        // That fires when a page's URL contains a 'g' ...
        conditions: [
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { pathContains: 'term' },
          }),
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { pathContains: 'policy' },
          }),
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { pathContains: 'tos' },
          }),
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { pathContains: 'agreement' },
          }),
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { pathContains: 'rules' },
          }),
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { pathContains: 'contract' },
          }),
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { pathContains: 'privacy' },
          }),
          //just to match Global Legal Hackathon Rules page
          //the matcher is case sensitive
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { pathContains: 'Rules'},
          }),
        ],
        // And shows the extension's page action.
        actions: [ new chrome.declarativeContent.ShowPageAction() ]
      }
    ]);
  });
});
