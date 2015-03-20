xquery version "3.0";

import module "http://expath.org/ns/user-agent";

declare namespace ua = "http://expath.org/ns/user-agent";
declare namespace oxy = "http://oxygenxml.com/extensions/author";

declare variable $ua:document as element() external;

ua:add-event-listener($ua:document, "load", oxy:execute-action-by-name('Author/No_tags')),
ua:add-event-listener($ua:document, "load", oxy:execute-action-by-class('ro.kuberam.oxygen.addonBuilder.actions.KeepAuthorView')),

ua:action(
    "renameToPlaceName",
    map { 
        "name" := "placeName",
        "smallIconPath" := "${framework}/resources/images/placeName.png"
    },   
    rename node . as "placeName"
)
,
ua:action(
    "renameToPersName",
    map { 
        "name" := "persName",
        "smallIconPath" := "${framework}/resources/images/persName.png"
    },   
    rename node . as "persName"
)
,
ua:action(
    "renameToOrgName",
    map { 
        "name" := "org",
        "smallIconPath" := "${framework}/resources/images/orgName.png"
    },   
    rename node . as "orgName"
)
,
ua:action(
    "renameToDate",
    map { 
        "name" := "date",
        "smallIconPath" := "${framework}/resources/images/date.png"
    },   
    rename node . as "date"
)
,
ua:action(
    "deleteElement",
    map { 
        "name" := "Delete",
        "smallIconPath" := "${framework}/resources/images/delete.png"
    },   
    replace node . with ./text()
)
,
ua:action(
    "placeNameWrapping",
    map { 
        "name" := "placeNameWrapping",
        "smallIconPath" := "${framework}/resources/images/placeName.png"
    },   
    ua:range-surround-contents(ua:selection-get-range-at(1), <placeName xmlns="http://www.tei-c.org/ns/1.0" />)
)
,
ua:action(
    "persNameWrapping",
    map { 
        "name" := "persNameWrapping",
        "smallIconPath" := "${framework}/resources/images/persName.png"
    },   
    ua:range-surround-contents(ua:selection-get-range-at(1), <persName xmlns="http://www.tei-c.org/ns/1.0" />)
)
,
ua:action(
    "orgNameWrapping",
    map { 
        "name" := "orgNameWrapping",
        "smallIconPath" := "${framework}/resources/images/orgName.png"
    },   
    ua:range-surround-contents(ua:selection-get-range-at(1), <orgName xmlns="http://www.tei-c.org/ns/1.0" />)
)
,
ua:action(
    "dateWrapping",
    map { 
        "name" := "dateWrapping",
        "smallIconPath" := "${framework}/resources/images/date.png"
    },   
    ua:range-surround-contents(ua:selection-get-range-at(1), <date xmlns="http://www.tei-c.org/ns/1.0" />)
)
,
ua:template("placeName-template",
<template>
    <button onclick="{oxy:execute-action-by-name('renameToPersName')}" style="background-color: transparent;" />
    <button onclick="{oxy:execute-action-by-name('renameToOrgName')}" style="background-color: transparent;" />
    <button onclick="{oxy:execute-action-by-name('renameToDate')}" style="background-color: transparent;" />
    <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
</template>
),
ua:attach-template(ua-dt:css-selector("note placeName:after"), "placeName-template")
,
ua:template("persName-template",
<template>
    <button onclick="{oxy:execute-action-by-name('renameToPlaceName')}" style="background-color: transparent;" />
    <button onclick="{oxy:execute-action-by-name('renameToOrgName')}" style="background-color: transparent;" />
    <button onclick="{oxy:execute-action-by-name('renameToDate')}" style="background-color: transparent;" />
    <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
</template>
),
ua:attach-template(ua-dt:css-selector("persName > persName:after, note persName:after"), "persName-template")
,
ua:template("orgName-template",
<template>
    <button onclick="{oxy:execute-action-by-name('renameToPlaceName')}" style="background-color: transparent;" />
    <button onclick="{oxy:execute-action-by-name('renameToPersName')}" style="background-color: transparent;" />
    <button onclick="{oxy:execute-action-by-name('renameToDate')}" style="background-color: transparent;" />
    <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
</template>
),
ua:attach-template(ua-dt:css-selector("note orgName:after"), "orgName-template")
,
ua:template("date-template",
<template>
    <button onclick="{oxy:execute-action-by-name('renameToPlaceName')}" style="background-color: transparent;" />
    <button onclick="{oxy:execute-action-by-name('renameToPersName')}" style="background-color: transparent;" />
    <button onclick="{oxy:execute-action-by-name('renameToOrgName')}" style="background-color: transparent;" />
    <button onclick="{oxy:execute-action-by-name('deleteElement')}" style="background-color: transparent;" />
</template>
),
ua:attach-template(ua-dt:css-selector("note date:after"), "date-template")
,
ua:template("toolbar-template",
<template>
    Note
    <button onclick="{oxy:execute-action-by-name('placeNameWrapping')}" style="background-color: transparent;" />
    <button onclick="{oxy:execute-action-by-name('persNameWrapping')}" style="background-color: transparent;" />
    <button onclick="{oxy:execute-action-by-name('orgNameWrapping')}" style="background-color: transparent;" />
    <button onclick="{oxy:execute-action-by-name('dateWrapping')}" style="background-color: transparent;" />
    \00000A
</template>
),
ua:attach-template(ua-dt:css-selector("note:before"), "toolbar-template")
