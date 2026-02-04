# VISIVA® Brand Design Platform

## Overview
A static Progressive Web App (PWA) for brand design and management. This is a framework-free HTML/CSS/JavaScript website that includes marketing pages, a client portal, and AI-ready tools.

## Project Structure
- `/` - Root contains marketing pages (index.html, about.html, pricing.html, etc.)
- `/client/` - Client portal with auth, dashboard, and project management
- `/portal/` - AI-powered brand tools (brand-dna, color-generator, etc.)
- `/css/` - Stylesheets
- `/js/` - JavaScript files including PWA service worker
- `/assets/` - Static assets and downloads

## Running the Project
The website is served using the `serve` package on port 5000.

Command: `npx serve -l 5000 -s .`

## Key Features
- Static HTML/CSS/JS (no backend required)
- PWA-enabled with service worker
- Client portal with localStorage-based auth
- AI tool interfaces ready for API integration

## Recent Changes
- Feb 2026: Initial Replit setup with static file server
