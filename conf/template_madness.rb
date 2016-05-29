require 'jbuilder'

class Template
  def initialize(s)
    @source = s
  end

  def render(view, locals)
    method_name = '_skybot_template_render'
    @locals = locals
    compile!(view)
    view.send(method_name, locals)
  end

private

  def locals_code
    @locals.keys.each_with_object('') { |key, code| code << "#{key} = #{key} = local_assigns[:#{key}];" }
  end

  def compile!(view)
    compile(view.singleton_class)
  end

  def compile(mod)
    method_name = '_skybot_template_render'
    code = <<-end_src
      def #{method_name}(local_assigns)
        #{locals_code}
        json ||= Jbuilder.new
        #{@source}
        MultiJson.dump(json.attributes!, pretty: true)
      end
    end_src

    mod.module_eval(code, 'config.json.jbuilder', 0)
  end
end