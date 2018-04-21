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
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { pathContains: 'legal' },
          }),
          //just to match Global Legal Hackathon Rules page
          //the matcher is case sensitive
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { pathContains: 'Rules'},
          }),
          //just to match Walmart tos page
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { pathContains: 'answers'},
          }),
          //just to match Bitrex tos page
          //the matcher is case sensitive
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { pathContains: 'Term'},
          }),
          //just to match Amazon tos page
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { hostContains: 'amazon', pathContains: 'help'},
          }),
          //just to match Instagram tos page
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { hostContains: 'help.instagram'},
          }),
          //just to match tryadelinaskin tos page
          new chrome.declarativeContent.PageStateMatcher({
            pageUrl: { hostContains: 'tryadelinaskin'},
          }),
        ],
        // And shows the extension's page action.
        actions: [ new chrome.declarativeContent.ShowPageAction() ]
      }
    ]);
  });
});
