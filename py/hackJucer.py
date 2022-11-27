
print("HACK JUCER: started")
import os
import platform
import re

androidNDK = os.environ['ANDROID_NDK_HOME']
androidSDK = os.environ['ANDROID_HOME']
androidVersionCode = os.environ['SS_ANDROID_VERSION']

EDITOAR_JUCER = 'p/Editoar/Editoar.jucer'

CWD = os.getcwd()

OS = platform.system()

JUCE_FOLDER = '../JUCE'
if OS == 'Windows':
  SKOARCERY = CWD + '\\p\\Skoarcery'
  SKOARCERY_SRC = SKOARCERY + '\\SkoarCpp'
  SKOARCERY_SRC_REL = '../Skoarcery/SkoarCpp'
  JUCE_MODULES = '..\\JUCE\\modules'
else:
  SKOARCERY = CWD + '/p/Skoarcery'
  SKOARCERY_SRC = SKOARCERY + '/SkoarCpp'
  SKOARCERY_SRC_REL = '../Skoarcery/SkoarCpp'
  JUCE_MODULES = '../JUCE/modules'

import xml.etree.ElementTree as ET

print("Hacking " + EDITOAR_JUCER)
tree = ET.parse(EDITOAR_JUCER)
root = tree.getroot()    

print('Hacking JucerProject')
print('Hacking Version number to: 1.' + androidVersionCode)
for jucerproject in root.iter('JUCERPROJECT'):
  jucerproject.attrib['version'] = '1.' + androidVersionCode
  jucerproject.attrib['juceFolder'] = JUCE_FOLDER

print('Hacking VS2015 exporter.')
for exporter in root.iter('VS2015'):
  for config in exporter.iter('CONFIGURATION'):
    name = config.attrib['name']
    config.attrib['headerPath'] = SKOARCERY_SRC
  for modulePath in exporter.iter('MODULEPATH'):
    modulePath.attrib['path'] = JUCE_MODULES

print('Hacking VS2017 exporter.')
for exporter in root.iter('VS2017'):
  for config in exporter.iter('CONFIGURATION'):
    name = config.attrib['name']
    config.attrib['headerPath'] = SKOARCERY_SRC
  for modulePath in exporter.iter('MODULEPATH'):
    modulePath.attrib['path'] = JUCE_MODULES

print('Hacking OSX exporter.')
for exporter in root.iter('XCODE_MAC'):
  for config in exporter.iter('CONFIGURATION'):
    name = config.attrib['name']
    config.attrib['headerPath'] = SKOARCERY_SRC
  for modulePath in exporter.iter('MODULEPATH'):
    modulePath.attrib['path'] = JUCE_MODULES

print('Hacking Linux Makefile exporter.')
for exporter in root.iter('LINUX_MAKE'):
  for config in exporter.iter('CONFIGURATION'):
    name = config.attrib['name']
    config.attrib['headerPath'] = SKOARCERY_SRC
  for modulePath in exporter.iter('MODULEPATH'):
    modulePath.attrib['path'] = JUCE_MODULES

print('Hacking out global module paths')
for modules in root.iter('MODULES'):
  for module in modules.iter('MODULE'):
    module.attrib['useGlobalPath'] = '0'

print('Hacking out SkoarCpp paths')
for group in root.iter('GROUP'):
  groupName = group.attrib['name']
  if groupName == 'UnitTests' or groupName == 'SkoarCpp':
    for f in group.iter('FILE'):
      filename = f.attrib['file']
      newFilename = re.sub(r'.*/SkoarCpp', SKOARCERY_SRC_REL, filename)
      f.attrib['file'] = newFilename

print("Saving " + EDITOAR_JUCER)

tree.write(EDITOAR_JUCER, encoding="UTF-8", xml_declaration=True)

# ==============================================================

sna = '''
print("Hacking " + EDITOAR_MOBILE_JUCER)
tree = ET.parse(EDITOAR_MOBILE_JUCER)
root = tree.getroot()    


print('Hacking JucerProject')
print('Hacking Version number to: 1.' + androidVersionCode)
for jucerproject in root.iter('JUCERPROJECT'):
  jucerproject.attrib['version'] = '1.' + androidVersionCode

print('Hacking Android exporters.')
for exporter in root.iter('ANDROIDSTUDIO'):
  exporter.attrib['androidSDKPath'] = androidSDK
  exporter.attrib['androidNDKPath'] = androidNDK
  exporter.attrib['androidVersionCode'] = androidVersionCode
  exporter.attrib['cppLanguageStandard'] = '-std=c++17'
  for config in exporter.iter('CONFIGURATION'):
    config.attrib['headerPath'] = SKOARCERY_SRC
  for modulePath in exporter.iter('MODULEPATH'):
    modulePath.attrib['path'] = JUCE_MODULES

print('Hacking OSX exporter.')
for exporter in root.iter('XCODE_IPHONE'):
  for config in exporter.iter('CONFIGURATION'):
    name = config.attrib['name']
    config.attrib['headerPath'] = SKOARCERY_SRC
  for modulePath in exporter.iter('MODULEPATH'):
    modulePath.attrib['path'] = JUCE_MODULES

print('Hacking VS2017 exporter.')
for exporter in root.iter('VS2017'):
  for config in exporter.iter('CONFIGURATION'):
    name = config.attrib['name']
    config.attrib['headerPath'] = SKOARCERY_SRC
  for modulePath in exporter.iter('MODULEPATH'):
    modulePath.attrib['path'] = JUCE_MODULES

print('Hacking out global module paths')
for modules in root.iter('MODULES'):
  for module in modules.iter('MODULE'):
    module.attrib['useGlobalPath'] = '0'

print("Saving " + EDITOAR_MOBILE_JUCER)

tree.write(EDITOAR_MOBILE_JUCER, encoding="UTF-8", xml_declaration=True)
'''

print("Hacking jucers done.")
