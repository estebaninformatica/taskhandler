require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  #Esteban Fuhrmann ( esteban.informatica@gmail.com)
  #http://edgeguides.rubyonrails.org/testing.html
  #Este es un espacio donde se deben escribir los test de Unidad
  #Vamos a realizar un test como ejemplo, testeamos que al crear un proyecto
  #sin un titulo tire un error (VALIDADORES Y MENSAJES).
  #Para probar esto deshabilite los fixture
  #preunto si es valido projecto y tiene que tirar 2 errores por que no tiene title ni description.

  test 'present attributes' do
    project = Project.new
    assert project.invalid?
    assert_equal 2, project.errors.size
  end

  test 'unique attributes' do
    pro = Project.new

    pro.title = projects(:one).title
    pro.description = "Alguna description"
    assert pro.invalid?
    assert_equal 1, pro.errors.size
  end

end
