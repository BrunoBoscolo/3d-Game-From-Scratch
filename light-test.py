import sys
import math
import pygame

class vec3d:
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z

    def getCoordinates(self):
        return [self.x, self.y, self.z]

class triangle:
    def __init__(self, v1:vec3d, v2:vec3d, v3:vec3d):
        self.vertices = [v1,v2,v3]
        self.red = None
        self.green = None
        self.blue = None
    
    def setVertice(self, vectorIndex, vector):
        self.vertices[vectorIndex] = vector

    def getVertice(self, verticeIndex, vectorIndex, vector):
        try:
            return self.vertices[verticeIndex][vectorIndex]  
        except:
            return False
        
    def printVertices(self):
        for i, v in enumerate(self.vertices):
            print(f"Vertex {i+1}: ({v.x}, {v.y}, {v.z})")
    
class mesh:
    def __init__(self):
        self.tris = []

    def addTriangle(self, triangle):
        self.tris.append(triangle)
    
    def getTriangle(self, triangleIndex):
        try:
            return self.tris[triangleIndex]
        except:
            return False

class matrix4x4:
    def __init__(self):
        self.matrix = [[0] * 4 for _ in range(4)]

    def setValue(self, line, column, value):
        self.matrix[line][column] = value