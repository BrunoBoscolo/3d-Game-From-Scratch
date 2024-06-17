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

#mesh for test

def loadObjectFile(filename):
    objMesh = mesh()
    vertexes = []

    try:
        with open(filename, 'r') as file:
            for line in file:
                pieces = line.strip().split()

                if pieces[0] == "v":
                    vector = vec3d(0, 0, 0)
                    vector.x = float(pieces[1])
                    vector.y = float(pieces[2])
                    vector.z = float(pieces[3])
                    vertexes.append(vector)

                if pieces[0] == "f":
                    v1Index = int(pieces[1]) - 1
                    v2Index = int(pieces[2]) - 1
                    v3Index = int(pieces[3]) - 1

                    v1 = vertexes[v1Index]
                    v2 = vertexes[v2Index]
                    v3 = vertexes[v3Index]

                    objMesh.tris.append(triangle(v1, v2, v3))

    except Exception as e:
        print("Error loading object file:", e)
        return False

    return objMesh

def meshCubeSetup():
    meshCube = mesh()

    # South face (clockwise order)
    south_face_1 = triangle(vec3d(0.0, 0.0, 0.0), vec3d(0.0, 1.0, 0.0), vec3d(1.0, 1.0, 0.0))
    meshCube.addTriangle(south_face_1)

    south_face_2 = triangle(vec3d(0.0, 0.0, 0.0), vec3d(1.0, 1.0, 0.0), vec3d(1.0, 0.0, 0.0))
    meshCube.addTriangle(south_face_2)

    # East face (clockwise order)
    east_face_1 = triangle(vec3d(1.0, 0.0, 0.0), vec3d(1.0, 1.0, 0.0), vec3d(1.0, 1.0, 1.0))
    meshCube.addTriangle(east_face_1)

    east_face_2 = triangle(vec3d(1.0, 0.0, 0.0), vec3d(1.0, 1.0, 1.0), vec3d(1.0, 0.0, 1.0))
    meshCube.addTriangle(east_face_2)

    # North face (clockwise order)
    north_face_1 = triangle(vec3d(1.0, 0.0, 1.0), vec3d(1.0, 1.0, 1.0), vec3d(0.0, 1.0, 1.0))
    meshCube.addTriangle(north_face_1)

    north_face_2 = triangle(vec3d(1.0, 0.0, 1.0), vec3d(0.0, 1.0, 1.0), vec3d(0.0, 0.0, 1.0))
    meshCube.addTriangle(north_face_2)

    # West face (clockwise order)
    west_face_1 = triangle(vec3d(0.0, 0.0, 1.0), vec3d(0.0, 1.0, 1.0), vec3d(0.0, 1.0, 0.0))
    meshCube.addTriangle(west_face_1)

    west_face_2 = triangle(vec3d(0.0, 0.0, 1.0), vec3d(0.0, 1.0, 0.0), vec3d(0.0, 0.0, 0.0))
    meshCube.addTriangle(west_face_2)

    # Top face (clockwise order)
    top_face_1 = triangle(vec3d(0.0, 1.0, 0.0), vec3d(0.0, 1.0, 1.0), vec3d(1.0, 1.0, 1.0))
    meshCube.addTriangle(top_face_1)

    top_face_2 = triangle(vec3d(0.0, 1.0, 0.0), vec3d(1.0, 1.0, 1.0), vec3d(1.0, 1.0, 0.0))
    meshCube.addTriangle(top_face_2)

    # Bottom face (clockwise order)
    bottom_face_1 = triangle(vec3d(1.0, 0.0, 1.0), vec3d(0.0, 0.0, 1.0), vec3d(0.0, 0.0, 0.0))
    meshCube.addTriangle(bottom_face_1)

    bottom_face_2 = triangle(vec3d(1.0, 0.0, 1.0), vec3d(0.0, 0.0, 0.0), vec3d(1.0, 0.0, 0.0))
    meshCube.addTriangle(bottom_face_2)

    return meshCube

def MatrixVectorMultiplication(v, projMat):
    vOut = vec3d(0, 0, 0)
    
    vOut.x = (v.x * projMat.matrix[0][0]) + (v.y * projMat.matrix[1][0]) + (v.z * projMat.matrix[2][0]) + (projMat.matrix[3][0])
    vOut.y = (v.x * projMat.matrix[0][1]) + (v.y * projMat.matrix[1][1]) + (v.z * projMat.matrix[2][1]) + (projMat.matrix[3][1])
    vOut.z = (v.x * projMat.matrix[0][2]) + (v.y * projMat.matrix[1][2]) + (v.z * projMat.matrix[2][2]) + (projMat.matrix[3][2])
    w = (v.x * projMat.matrix[0][3]) + (v.y * projMat.matrix[1][3]) + (v.z * projMat.matrix[2][3]) + (projMat.matrix[3][3])
    
    if w != 0:  # We do not want a division by 0
        vOut.x = vOut.x / w
        vOut.y = vOut.y / w
        vOut.z = vOut.z / w
    
    return vOut

def setupProjectionMatrix(screenWidth, screenHeight, near=0.1, far=1000.0, fov=90.0):
    aspectRatio = screenHeight / screenWidth
    fovRad = 1.0 / math.tan((fov * 0.5) / (180.0 * math.pi))  # FOV in radians

    projectionMatrix = matrix4x4()

    projectionMatrix.setValue(0, 0, aspectRatio * fovRad)
    projectionMatrix.setValue(1, 1, fovRad)
    projectionMatrix.setValue(2, 2, far / (far - near))
    projectionMatrix.setValue(3, 2, (-far * near) / (far - near))
    projectionMatrix.setValue(2, 3, 1.0)
    projectionMatrix.setValue(3, 3, 0.0)

    return projectionMatrix

def xRotationMatrixSetup(xtheta):
    xRotMat = matrix4x4()

    xRotMat.setValue(0, 0, 1)
    xRotMat.setValue(1, 1, math.cos(xtheta * 0.5))
    xRotMat.setValue(1, 2, math.sin(xtheta * 0.5))
    xRotMat.setValue(2, 1, -math.sin(xtheta * 0.5))
    xRotMat.setValue(2, 2, math.cos(xtheta * 0.5))
    xRotMat.setValue(3, 3, 1)

    return xRotMat

def zRotationMatrixSetup(ztheta):
    zRotMat = matrix4x4()

    zRotMat.setValue(0, 0, math.cos(ztheta))
    zRotMat.setValue(0, 1, math.sin(ztheta))
    zRotMat.setValue(1, 0, -math.sin(ztheta))
    zRotMat.setValue(1, 1, math.cos(ztheta))
    zRotMat.setValue(2, 2, 1)
    zRotMat.setValue(3, 3, 1)

    return zRotMat

def translateTriangle(t, tx, ty, tz):
    vOut0 = vec3d(0, 0, 0)
    vOut1 = vec3d(0, 0, 0)
    vOut2 = vec3d(0, 0, 0)

    v0 = t.vertices[0]
    v1 = t.vertices[1]
    v2 = t.vertices[2]

    vOut0.x = v0.x + tx
    vOut0.y = v0.y + ty
    vOut0.z = v0.z + tz

    vOut1.x = v1.x + tx
    vOut1.y = v1.y + ty
    vOut1.z = v1.z + tz

    vOut2.x = v2.x + tx
    vOut2.y = v2.y + ty
    vOut2.z = v2.z + tz

    tTranslated = triangle

    tTranslated.vertices = [vOut0, vOut1, vOut2]

    return tTranslated

def rotateTriangle(t, xRotMat, zRotMat):
    vOut0 = vec3d(0, 0, 0)
    vOut1 = vec3d(0, 0, 0)
    vOut2 = vec3d(0, 0, 0)

    v0 = t.vertices[0]
    v1 = t.vertices[1]
    v2 = t.vertices[2]

    vOut0 = MatrixVectorMultiplication(v0, zRotMat)
    vOut1 = MatrixVectorMultiplication(v1, zRotMat)
    vOut2 = MatrixVectorMultiplication(v2, zRotMat)

    vOut0 = MatrixVectorMultiplication(vOut0, xRotMat)
    vOut1 = MatrixVectorMultiplication(vOut1, xRotMat)
    vOut2 = MatrixVectorMultiplication(vOut2, xRotMat)

    tRotated = triangle

    tRotated.vertices = [vOut0, vOut1, vOut2]

    return tRotated

def scaleTriangle(t, sX, sY, sZ):
    vOut0 = vec3d(0, 0, 0)
    vOut1 = vec3d(0, 0, 0)
    vOut2 = vec3d(0, 0, 0)

    v0 = t.vertices[0]
    v1 = t.vertices[1]
    v2 = t.vertices[2]

    vOut0.x = v0.x * sX
    vOut0.y = v0.y * sY
    vOut0.z = v0.z * sZ

    vOut1.x = v1.x * sX
    vOut1.y = v1.y * sY
    vOut1.z = v1.z * sZ

    vOut2.x = v2.x * sX
    vOut2.y = v2.y * sY
    vOut2.z = v2.z * sZ

    tScaled = triangle

    tScaled.vertices = [vOut0, vOut1, vOut2]

    return tScaled

def calculateNormal(triangle: triangle):
    vertices = triangle.vertices

    line1 = vec3d(0,0,0)
    line2 = vec3d(0,0,0)
    normal = vec3d(0,0,0)
    
    line1.x = vertices[1].x - vertices[0].x
    line1.y = vertices[1].y - vertices[0].y
    line1.z = vertices[1].z - vertices[0].z

    line2.x = vertices[2].x - vertices[0].x
    line2.y = vertices[2].y - vertices[0].y
    line2.z = vertices[2].z - vertices[0].z

    normal.x = line1.y * line2.z - line1.z * line2.y
    normal.y = line1.z * line2.x - line1.x * line2.z
    normal.z = line1.x * line2.y - line1.y * line2.x

    lenght = math.sqrt(normal.x*normal.x + normal.y*normal.y + normal.z*normal.z)
    
    normal.x /= lenght
    normal.z /= lenght
    normal.y /= lenght

    return normal

def calculateTriangleNormal(triangle: triangle, camera:vec3d):
    vertices = triangle.vertices

    line1 = vec3d(0,0,0)
    line2 = vec3d(0,0,0)
    normal = vec3d(0,0,0)
    
    line1.x = vertices[1].x - vertices[0].x
    line1.y = vertices[1].y - vertices[0].y
    line1.z = vertices[1].z - vertices[0].z

    line2.x = vertices[2].x - vertices[0].x
    line2.y = vertices[2].y - vertices[0].y
    line2.z = vertices[2].z - vertices[0].z

    normal.x = line1.y * line2.z - line1.z * line2.y
    normal.y = line1.z * line2.x - line1.x * line2.z
    normal.z = line1.x * line2.y - line1.y * line2.x

    lenght = math.sqrt(normal.x*normal.x + normal.y*normal.y + normal.z*normal.z)
    
    if lenght == 0:
        lenght = 0.00001

    normal.x /= lenght
    normal.z /= lenght
    normal.y /= lenght

    if ((normal.x * (triangle.vertices[0].x - camera.x)) +
       (normal.y * (triangle.vertices[0].y - camera.y)) +
       (normal.z * (triangle.vertices[0].z - camera.z)) < 0):
        return True
    else:
        return False

def drawProjectedTriangleOutline(t, camera):
    # Temporary translation values
    tx = 5
    ty = 5
    tz = 10

    #print('Original Triangle:')
    #t.printVertices()

    # Rotate vertices
    rotatedTriangle = rotateTriangle(t, xRotMat, zRotMat)

    #print('Rotated Triangle:')
    #rotatedTriangle.printVertices()

    # Translate vertices
    translatedTriangle = translateTriangle(rotatedTriangle, tx, ty, tz)

    #print('Translated Triangle:')
    #translatedTriangle.printVertices()

    isVisible = calculateTriangleNormal(translatedTriangle, camera)

    if isVisible:
        # Project vertices using the projection matrix
        projectedTriangle = triangle

        projectedTriangle.vertices = [MatrixVectorMultiplication(translatedTriangle.vertices[0], projectionMatrix),
                                    MatrixVectorMultiplication(translatedTriangle.vertices[1], projectionMatrix),
                                    MatrixVectorMultiplication(translatedTriangle.vertices[2], projectionMatrix)]

        #print('Projected Triangle:')
        #projectedTriangle.printVertices()

        scaledTriangle = scaleTriangle(projectedTriangle, 40, 40, 40)

        #print('Scaled Triangle:')
        #scaledTriangle.printVertices()

        return scaledTriangle, t
    else:
        return False, False

def getTriangleShading(triangle: triangle, lightDirection: vec3d):
    vertices = triangle.vertices

    line1 = vec3d(0,0,0)
    line2 = vec3d(0,0,0)
    triangleNormal = vec3d(0,0,0)
    
    line1.x = vertices[1].x - vertices[0].x
    line1.y = vertices[1].y - vertices[0].y
    line1.z = vertices[1].z - vertices[0].z

    line2.x = vertices[2].x - vertices[0].x
    line2.y = vertices[2].y - vertices[0].y
    line2.z = vertices[2].z - vertices[0].z

    triangleNormal.x = line1.y * line2.z - line1.z * line2.y
    triangleNormal.y = line1.z * line2.x - line1.x * line2.z
    triangleNormal.z = line1.x * line2.y - line1.y * line2.x

    print("----------------------------------------------")

    print(f"Normal vector {triangleNormal.x,triangleNormal.y,triangleNormal.z}")

    lNormal = math.sqrt(triangleNormal.x**2 + triangleNormal.y**2 + triangleNormal.z**2)
    print(f"Normal len {lNormal}")
    triangleNormal.x /= lNormal
    triangleNormal.y /= lNormal
    triangleNormal.z /= lNormal

    print(f"Normalized normal vector {triangleNormal.x,triangleNormal.y,triangleNormal.z}")

    print(f"Light vector {lightDirection.x,lightDirection.y,lightDirection.z}")
    l = math.sqrt(lightDirection.x**2 + lightDirection.y**2 + lightDirection.z**2)
    print(f"light len {l}")
    lightDirection.x /= l
    lightDirection.y /= l
    lightDirection.z /= l
    
    print(f"Normalized light vector {lightDirection.x,lightDirection.y,lightDirection.z}")

    

    dp = (triangleNormal.x * lightDirection.x) + (triangleNormal.y * lightDirection.y) + (triangleNormal.z * lightDirection.z)
    
    if dp <= 0.1 :
        intensity = 0
    elif (dp <= 0.25):
        intensity = 63
    elif (dp <= 0.50):
        intensity = 128
    elif (dp <= 0.75):
        intensity = 190
    else: 
        intensity = 255
    
    print(dp, intensity)

    print("----------------------------------------------")
    return intensity

def drawTriangleNormal(triangle: triangle, screen):
    normal = calculateNormal(triangle)

    # Calculate the midpoint of the triangle
    midpoint = vec3d(0, 0, 0)
    for vertex in triangle.vertices:
        midpoint.x += vertex.x
        midpoint.y += vertex.y
        midpoint.z += vertex.z
    midpoint.x /= 3
    midpoint.y /= 3
    midpoint.z /= 3

    # Determine color based on the z component of the normal
    color = (255, 0, 0)  # Default color is red
    if normal.z < 0:
        color = (0, 0, 255)  # If z component is negative, color is blue

    # Draw the normal line
    pygame.draw.line(screen, color, (midpoint.x, midpoint.y), (midpoint.x + normal.x * 20, midpoint.y + normal.y * 20), 2)


if __name__ == '__main__':
    SCREEN_WIDTH = 800.0
    SCREEN_HEIGHT = 800.0
    BLACK = (0, 0, 0)
    WHITE = (255, 255, 255)

    thetax = 0
    thetaz = 0

    meshCube = loadObjectFile('objects\VideoShip.obj')
    projectionMatrix = setupProjectionMatrix(SCREEN_WIDTH, SCREEN_HEIGHT)
    xRotMat = xRotationMatrixSetup(thetax)
    zRotMat = zRotationMatrixSetup(thetaz)

    camera = vec3d(0,0,0)
    lightDirection = vec3d(0,0,-1)

    pygame.init()
    pygame.display.set_caption("Pygame Window")
    screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
    
    while True:
        thetax += 0.01
        thetaz += 0.01
        xRotMat = xRotationMatrixSetup(thetax)
        zRotMat = zRotationMatrixSetup(thetaz)
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()

            # Poll the state of the keyboard
            keys = pygame.key.get_pressed()
            
            # Check if the "w" key is pressed
            if keys[pygame.K_w]:
                w_pressed = True
                thetax += 0.02
            else:
                w_pressed = False

            # Check if the "s" key is pressed
            if keys[pygame.K_s]:
                s_pressed = True
                thetax -= 0.02
            else:
                s_pressed = False

        screen.fill(BLACK)

        for triangles in meshCube.tris:
            projectedTriangle, originalTriangle = drawProjectedTriangleOutline(triangles, camera)

            if projectedTriangle:
                vertices = projectedTriangle.vertices
                shading = getTriangleShading(projectedTriangle, lightDirection)
                drawTriangleNormal(projectedTriangle, screen)
                #pygame.draw.polygon(screen, (shading, shading, shading), [(vertices[0].x,vertices[0].y),(vertices[1].x,vertices[1].y),(vertices[2].x,vertices[2].y)])
                pygame.draw.aalines(screen, WHITE, True, [(vertices[0].x,vertices[0].y),(vertices[1].x,vertices[1].y),(vertices[2].x,vertices[2].y)])
        
        pygame.display.flip()

        pygame.time.Clock().tick(60)

    

    