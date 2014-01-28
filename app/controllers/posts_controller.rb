require 'tesseract'
class PostsController < ApplicationController
    # GET /posts
    def index
        #@post = Post.find(:all, :order => 'posts.created_at DESC').paginate(:page => params[:page], :per_page => 5)
        @post = Post.find(:all, :order => 'posts.created_at DESC')
        #@post = Post.all.reverse.paginate(:page => params[:page], :per_page => 5)
        respond_to do |format|
            format.html # index.html.erb
        end
    end

    # GET /posts/1
    def show
        @post = Post.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
        end
    end

    # GET /posts/1/edit
    def edit
        @post = Post.find(params[:id])
    end

    # POST /posts
    def create
        @post = Post.new(params[:post].permit(:nature,:content,:caption,:user,:att_file,:tags_list))
        @post.posted_by_uid=current_user.id
        @post.posted_by=current_user.name
        #@post.user = current_user
        @post.ups=0
        @post.downs=0
	@blacklist=Blacklist.all.pluck('word')
        e = Tesseract::Engine.new {|e|
            e.language  = :eng
            e.blacklist = @blacklist
        }

        @post.save
        respond_to do |format|
            if @post.save
		@path= Rails.root.to_s() + '/public' +@post.att_file.url
                ocr_link=(@path).split('?')
                #Here the adding of tags starts
		x=[]
                y=[]
                begin
                    a=e.text_for(ocr_link[0]).strip
		    y= @post.content.split(' ')
                    z=a.split(' ')
		    z.each do |w|
		      puts w.length
		      if w.length <= 4		#Decides min word length !!!!!
			puts z.delete_at(z.index(w))
		      end
		    end
		    z=z.join(" ")        
		    x = word_frequencies(z+" "+@post.content,5)
                    #z= @post.caption.split(' ')
                rescue
                    puts "------------------------"
                    puts "Couldn't find the frequency"
                    puts "------------------------"
                end
                puts "----------------------"
                puts "tags"  
                puts "----------------------"
                @post.tag_list.add(x+y)
                @post.save
                #Ends here (hopefully)
                format.html { redirect_to root_path }
                format.json { render :json => @post, :status => :created, :location => @post }
            else
                format.html { redirect_to root_path }
                format.json { render :json => @post.errors, :status => :unprocessable_entity }
            end
        end
    end
    def word_frequencies(string, n)
        words = string.split(/\s/)  # O(n)
        max = 0
        min = Float::INFINITY
        frequencies = words.inject(Hash.new(0)) do |hash,word|  # O(k)
            occurrences = hash[word] += 1                     # O(1)
            max = occurrences if occurrences > max            # O(1)
            min = occurrences if occurrences < min            # O(1)
            hash;                                             # O(1)  
        end

        ### perform a counting sort ###
        sorted = Array.new(max + words.length)

        delta = 0

        frequencies.each do |word, frequency|   #O(k)
            #p word + "--" + frequency.to_s
            index = frequency
            if sorted[index]
                sorted[index] = sorted[index].push(word)  # ??? I think O(1).
            else
                sorted[index] = [word]                    # O(1)
            end
        end

        return sorted.compact.flatten[-n..-1].reverse   
        ### Compact is O(k).  Flatten is O(k).  Reverse is O(k). So O(3k)
    end

    # PUT /posts/1
    def update
        @post = Post.find(params[:id])

        respond_to do |format|
            if @post.update_attributes(params[:post])
                format.html { redirect_to @post, :notice => 'Post was successfully updated.' }
            else
                format.html { render :action => "edit" }
            end
        end
    end

    # DELETE /posts/1
    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        respond_to do |format|
            format.html { redirect_to root_path }
        end
    end
end
