#! /usr/bin/env python3
import os, sys, shutil

# def moveFilesToTargetDir(targetPath, dirPath = '.'):
#     for root, dirs, files in os.walk(dirPath):
#         if len(dirs) > 0 or root == dirPath:
#             for dirName in dirs:
#                 newName = 'new_tmp_dir_' + str(dirs.index(dirName) + 1)
#                 tmpDirPath = os.path.join(root, dirName)
#                 os.renames(tmpDirPath, os.path.join(root, newName))
#                 dirs[dirs.index(dirName)] = newName
#                 print('Rename: ' + dirName + ' to ' + newName)
#             # print('The path: ' + dirPath + ' does not have any directories!')
#
#             continue
#
#         else:
#             for fileName in files:
#                 tmpFilePath = os.path.join(root, fileName)
#                 print('The file: ' + tmpFilePath)
#                 shutil.move(tmpFilePath, targetPath)
#                 print('Move action: successfully!')
#                 os.rmdir(root)
#                 print('Remove: ' + root)
#
#     return

def moveFunc2(target, rootPath = '.'):
    probe = False
    fileList = os.listdir(rootPath)
    for fileName in fileList:
        filePath = os.path.join(rootPath, fileName)
        if os.path.isdir(filePath):
            moveFunc2(targetPath, filePath)
        else:
            targetIsRoot = targetPath == rootPath
            if targetIsRoot:
                probe = True
                continue
            else:
                tmpTargetPath = os.path.join(targetPath, fileName)
                if os.path.exists(tmpTargetPath):
                    print('The file: ' + fileName)
                    print('Path: ' + filePath)
                    print('It is exist in target path!')
                    print('Target Path: ' + targetPath)
                    overwrite = input('overwrite?(Y/n): ')
                    if overwrite.lower() == 'y':
                        os.remove(tmpTargetPath)
                        shutil.move(filePath, targetPath)
                        print('Overwritten: ' + fileName)
                    else:
                        rename = input('rename and move?(Y/n): ')
                        if rename.lower() == 'y':
                            reFileName = input('rename: ')
                            reFilePath = os.path.join(rootPath, reFileName)
                            os.renames(filePath, reFilePath)
                            shutil.move(reFilePath, targetPath)
                            print('Renamed and Moved: ' + reFileName)
                        else:
                            exit()
                else:
                    shutil.move(filePath, targetPath)
                    print('Moved: ' + fileName)

    if not probe:
        os.rmdir(rootPath)
        print('Removed: ' + rootPath)
            # if os.path.exists(tmpTargetPath) and not targetIsRoot:
            #     rename = input('The file is exist in target path, rename?(Y/n): ')
            #     if rename.lower() == 'y':
            #         os.renames(filePath, filePath + '.new')
            #     else:
            #         overwrite = input('overwrite?(Y/n): ')
            #         if overwrite.lower() == 'y':
            #
            # if not targetIsRoot:
            #     shutil.move(filePath, target)



    return

def splitFileName(path):
    fileDict = {}
    # extension = set()
    trash = set()
    use = set()
    if os.path.isabs(path):
        path = os.path.abspath(path)
    for file in os.listdir(path):
        if os.path.isdir(file):
            continue
        else:
            tmp = os.path.splitext(file)
            exName = tmp[1]
            if (exName not in trash) and (exName not in use):
                judge = input('Extension name: ' + exName + ', ignore?(Enter to ignore / N): ')
                if judge == '':
                    trash.add(exName)
                    continue
                elif judge.lower() == 'n':
                    use.add(exName)
                    fileDict.setdefault(exName, set()).add(tmp[0])
            elif exName in use:
                fileDict.setdefault(exName, set()).add(tmp[0])
                # extension.add(exName)
    use.clear()
    trash.clear()

    return fileDict

def renameSelectFile(dict, targetPath, no = 1):
    if no == 1:
        for exName, fileSet in dict.items():
            nameFormat = input('Input the new name format for extension ' + exName + ': ')
            sure = input('are you sure to rename format? Format: ' + nameFormat)
            if sure != '':
                exit()
            else:
                # formatPath = targetPath + nameFormat + '/'
                formatPath = os.path.join(targetPath, nameFormat)
                # print('formatPath:' + formatPath)
                fileList = list(fileSet)
                fileList.sort()
                for filePath in fileList:
                    # print('filePath:' + filePath)
                    newPath = formatPath + ('%02d' % (fileList.index(filePath)+1)) + exName
                    # newPath = os.path.join(formatPath, ('%02d' % (fileList.index(filePath)+1)) + exName)
                    # print('newPath: ' + newPath)
                    # oldPath = targetPath + filePath + exName
                    oldPath = os.path.join(targetPath, filePath + exName)
                    # print('oldPath: ' + oldPath)
                    os.renames(oldPath, newPath)
                    print('Renamed: ' + newPath)
    return

workingPath = os.path.abspath(sys.argv[1])
targetPath = workingPath
isExist = os.path.exists(workingPath)

if not isExist:
    print('Error: the path is not exist!')
    exit()
else:
    print('The working path: ' + workingPath)
    tmpTargetPath = input('Input the target path: ')
    if tmpTargetPath == '':
        print('Are you sure to setting as the default working path?')
        sureAction = input('Enter (Y/n): ')
        if sureAction.lower() == 'y':
            # targetPath = workingPath
            print('The target path is: ' + targetPath)
        else:
            print('Error: setting the default path failed!')
            exit()
    elif os.path.exists(tmpTargetPath):
        targetPath = os.path.abspath(tmpTargetPath)
        print('The target path is: ' + targetPath)
    else:
        print('Error: target path is not exist!')
        exit()
    # move files from sub-directories to current working path.
    # moveFilesToTargetDir(targetPath, workingPath)
    moveFlag = moveFunc2(targetPath, workingPath)
    print('Success: the files have been moved to the target directory!')
    selDict = splitFileName(targetPath)
    print("""\
    Select rename options:
    [1]: Positive sequence alignment
    """)
    selNo = input('Select: ')
    renameSelectFile(selDict, targetPath, int(selNo))
