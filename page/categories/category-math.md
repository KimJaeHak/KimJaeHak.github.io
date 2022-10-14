---
title: "Mathmatics"
layout: archive
permalink: /categories/Math
author_profile: true
sidebar_main: true
---

{% assign posts = site.categories['Math'] %}
{% for post in posts %} {% include archive-single.html type=page.entries_layout %} {% endfor %}