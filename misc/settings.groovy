#!groovy
import jenkins.model.*

// Update Theme to be the CrewNode theme
def descriptor = Jenkins.instance.getDescriptorByType(org.codefirst.SimpleThemeDecorator.class)
def url = '/userContent/crewnode-theme.css'
descriptor.setElements([new org.jenkinsci.plugins.simpletheme.CssUrlThemeElement(url)])
descriptor.save()
